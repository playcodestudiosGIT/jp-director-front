import 'package:flutter/material.dart';

import '../api/jp_api.dart';
import '../generated/l10n.dart';
import '../models/curso.dart';
import '../models/http/auth_response.dart';
import '../models/usuario_model.dart';
import '../router/router.dart';
import '../services/local_storage.dart';
import '../services/navigator_service.dart';
import '../services/notificacion_service.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  // ignore: unused_field
  late String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  List<Curso> _misCursos = [];

  bool isLoading = false;

  // ------ init AuthProvider --------//

  AuthProvider() {
    isAutenticated();
    // cursoView = _cursoDummy;
  }

// ------------------//

  Locale _locale = const Locale('es');
  Locale get locale => _locale;
  void setLocale(Locale value) {
    _locale = value;
    notifyListeners();
  }

  List<Curso> get misCursos => _misCursos;

  set misCursos(List<Curso> value) {
    _misCursos = value;
    notifyListeners();
  }

  // ------------ //

  login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    final appLocal = AppLocalizations.of(context);
    isLoading = true;
    final data = {'correo': email, 'password': password};

    JpApi.post('/auth/login', data).then((json) {
      final authResponse = AuthResponse.fromJson(json);
      if (!authResponse.usuario.estado) {
        NotifServ.showSnackbarError(appLocal.debeVerificar, Colors.red);
        NavigatorService.replaceTo(Flurorouter.loginRoute);
        isLoading = false;
        notifyListeners();
        return;
      }
      user = authResponse.usuario;
      _token = authResponse.token;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', json['token']);

      JpApi.configureDio();
      NavigatorService.replaceTo(Flurorouter.clienteMisCursosDash);
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      NotifServ.showSnackbarError(appLocal.credencialesInvalidas, Colors.red);
      notifyListeners();
    });
  }

  Future<bool> isAutenticated() async {
    isLoading = true;

    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      final resp = await JpApi.httpGet('/auth');
      final authResponse = AuthResponse.fromJson(resp);
      user = authResponse.usuario;
      _token = authResponse.token;
      authStatus = AuthStatus.authenticated;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      NotifServ.showSnackbarError('Error in Auth. contact admin', Colors.red);
      authStatus = AuthStatus.notAuthenticated;
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  logOut(BuildContext context) {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    NavigatorService.replaceTo(Flurorouter.homeRoute);
    isLoading = false;
    notifyListeners();
  }

  register(
      {required BuildContext context,
      required String correo,
      required String password,
      required String nombre,
      required String apellido,
      String telf = 'no value'}) async {
    final appLocal = AppLocalizations.of(context);
    isLoading = true;
    notifyListeners();
    final data = {
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'password': password,
      'telf': telf
    };
    JpApi.post('/usuarios', data).then((json) {
      isLoading = true;
      final authResponse = AuthResponse.fromJson(json);

      user = authResponse.usuario;
      _token = authResponse.token;

      if (!user!.estado) {
        NotifServ.showSnackbarError(
            appLocal.graciasPorRegistrarte, Colors.green);
        NavigatorService.navigateTo(Flurorouter.loginRoute);
        isLoading = false;
        notifyListeners();
        return;
      }
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigatorService.navigateTo(Flurorouter.clienteMisCursosDash);
      isLoading = false;
      notifyListeners();
      JpApi.configureDio();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.correoYaExiste, Colors.red);
    });
  }

  Future<bool> confirmEmail({required String token}) async {
    try {
      final resp = await JpApi.post('/auth/confirm/$token', {});
      if (resp['msg'] == 'ok') return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPass(
      {required String token, required String newPass}) async {
    final data = {"newPass": newPass};
    try {
      final resp = await JpApi.post('/auth/resetpass/$token', data);
      if (resp['msg'] == 'ok') return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendResetPass({required String email}) async {
    try {
      final resp = await JpApi.post('/auth/sendresetpass/$email', {});

      if (resp['msg'] == 'ok') {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future updateProg(
      {required String moduloId,
      required int marker,
      bool? isComplete = false}) async {
    final data = {
      'moduloId': moduloId,
      'marker': marker,
      'isComplete': isComplete
    };
    try {
      final json = await JpApi.put('/usuarios/prog/${user!.uid}', data);
      user = Usuario.fromJson(json);
      notifyListeners();
    } catch (e) {
      NotifServ.showSnackbarError('Error: contact admin', Colors.red);
    }
  }

  Future sendEmailSupport({
    required String nombre,
    required String apellido,
    required String correo,
    required String mensaje,
  }) async {
    final data = {
      "nombre": nombre,
      "apellido": apellido,
      "correo": correo,
      "mensaje": mensaje
    };
    try {
      await JpApi.post('/usuarios/support', data);
      NotifServ.showSnackbarError('Email sent to support', Colors.green);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future sendEmailToUser({
    required String nombre,
    required String apellido,
    required String correo,
    required String mensaje,
  }) async {
    final data = {
      "nombre": nombre,
      "apellido": apellido,
      "correo": correo,
      "mensaje": mensaje
    };
    try {
      await JpApi.post('/usuarios/contact-email', data);
      NotifServ.showSnackbarError('Email sent to user', Colors.green);
      return true;
    } catch (e) {
      return false;
    }
  }
}

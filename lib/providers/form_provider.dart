import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/models/formulario.dart';
import 'package:jp_director/models/http/forms_response.dart';
import 'package:universal_html/html.dart' as html;

import '../api/jp_api.dart';
import '../services/notificacion_service.dart';

class FormProvider extends ChangeNotifier {
  CarouselController formScrollController = CarouselController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>(debugLabel: 'keyForm');
  GlobalKey<FormState> keyForm2 = GlobalKey<FormState>(debugLabel: 'keyForm2');
  GlobalKey<FormState> keyForm3 = GlobalKey<FormState>(debugLabel: 'keyForm3');

  bool isLoading = false;

  final List<String> _pages = ['formp1', 'formp2', 'formp3', 'gracias'];
  int _currentIndex = 0;

  String rootForm = '';
  String email = '';
  String nombre = '';
  String telefono = '';
  String negocio = '';
  String opYear = '';
  bool pubBefore = false;
  String facebook = '';
  String instagram = '';
  String tiktok = '';
  String lvlpub = 'cero';
  String espectativas = '';
  bool isOnlineConference = true;
  String agree = '';

  List<Formulario> _allForms = [];
  int _totalForms = 0;

  setespectativas(String value) {
    espectativas = value;
    notifyListeners();
  }

  int get totalForms => _totalForms;

  set totalForms(int value) {
    _totalForms = value;
    notifyListeners();
  }

  List<Formulario> get allForms => _allForms;

  set allForms(List<Formulario> value) {
    _allForms = value;
    notifyListeners();
  }

  setResetForm() {
    rootForm = '';
    rootForm = '';
    email = '';
    nombre = '';
    telefono = '';
    negocio = '';
    opYear = '';
    pubBefore = false;
    facebook = '';
    espectativas = '';
    instagram = '';
    tiktok = '';
    lvlpub = 'cero';
    isOnlineConference = true;
    agree = '';
    notifyListeners();
  }

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setIsOnlineConference(value) {
    isOnlineConference = value;
  }

  setLvlPub(value) {
    lvlpub = value;
  }

  setRootForm(value) {
    rootForm = value;
  }

  setAgree(value) {
    agree = value;
  }

  setInstagram(value) {
    instagram = value;
  }

  setFacebook(value) {
    facebook = value;
  }

  setTiktok(value) {
    tiktok = value;
  }

  setPubBefore(value) {
    pubBefore = value;
  }

  setOpYear(value) {
    opYear = value;
  }

  setNegocio(value) {
    negocio = value;
  }

  setNombre(value) {
    nombre = value;
  }

  setTelefono(value) {
    telefono = value;
  }

  setEmail(value) {
    email = value;
  }

  setCurrentIndex(index) {
    _currentIndex = index;
  }

  setServicesIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }

  int getPageIndex() {
    return _currentIndex;
  }

  goTo(int index) {
    // final routeName = _pages[index];
    html.window.history.pushState(null, 'none', '#/${_pages[index]}');

    formScrollController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  getForms() async {
    // 0 - 100
    final resp = await JpApi.httpGet('/forms');
    final formsResponse = FromsResponse.fromJson(resp);

    _allForms = formsResponse.formularios;
    _allForms = formsResponse.formularios;

    notifyListeners();
  }

  Future<void> sendForm() async {
    final data = {
      "rootform": rootForm,
      "email": email,
      "nombre": nombre,
      "phone": telefono,
      "business": negocio,
      "operationyears": opYear,
      "advertisingbefore": pubBefore,
      "facebookurl": facebook,
      "instagramurl": instagram,
      "tiktokurl": tiktok,
      "advertisinglevel": lvlpub,
      "onlineconference": isOnlineConference,
      "agree": agree
    };
    try {
      await JpApi.post('/forms/', data);

      isLoading = false;
      notifyListeners();
      NotifServ.showSnackbarError('Submitted form', Colors.green);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      NotifServ.showSnackbarError('error sending form', Colors.red);
    }
  }

  Future deleteForm(String id) async {
    try {
      await JpApi.delete('/forms/$id', {});

      _allForms.removeWhere(
        (form) => form.uid == id,
      );

      notifyListeners();
      NotifServ.showSnackbarError('Form deleted', Colors.green);
      return true;
    } catch (e) {
      NotifServ.showSnackbarError('Error deleting form', Colors.red);
      throw Exception('Error en el delete form');
    }
  }

  updateForm(
    String? id,
  ) async {
    final data = {
      "rootform": rootForm,
      "email": email,
      "nombre": nombre,
      "phone": telefono,
      "business": negocio,
      "operationyears": opYear,
      "advertisingbefore": pubBefore,
      "facebookurl": facebook,
      "instagramurl": instagram,
      "advertisinglevel": lvlpub,
      "onlineconference": isOnlineConference,
      "agree": agree
    };

    try {
      final json = await JpApi.put('/forms/$id', data);

      _allForms = _allForms.map(
        (u) {
          if (u.uid != id) return u;
          u = Formulario.fromJson(json);
          return u;
        },
      ).toList();

      notifyListeners();
    } catch (e) {
      throw Exception('Error en el update user  $e');
    }
  }
}

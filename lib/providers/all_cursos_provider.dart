import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/services/notificacion_service.dart';

import '../api/jp_api.dart';
import '../models/curso.dart';
import '../models/http/all_cursos_response.dart';
import '../models/usuario_model.dart';

class AllCursosProvider extends ChangeNotifier {
  List<Curso> _allCursos = [];
  List<Curso> _misCursos = [];

  List<Curso> _cursosUserModalTemp = [];

  String? cursoSelected;
  int videoIndex = 0;

  Curso _cursoModal = cursoDummy;
  Curso _curso = cursoDummy;
  Curso _cursoView = cursoDummy;

  String _nombreCursoModal = '';
  String _subtitleCursoModal = '';
  String _descripcionCursoModal = '';
  String _imgCursoModal = '';
  String _duracionCursoModal = '';

  // --------------------------------- //

  Curso get cursoView => _cursoView;

  set cursoView(Curso value) {
    _cursoView = value;
    notifyListeners();
  }

  List<Curso> get misCursos => _misCursos;

  set misCursos(List<Curso> value) {
    _misCursos = value;
    notifyListeners();
  }

  String get duracionCursoModal => _duracionCursoModal;

  set duracionCursoModal(String value) {
    _duracionCursoModal = value;
    notifyListeners();
  }

  List<Curso> get cursosUserModalTemp => _cursosUserModalTemp;

  set cursosUserModalTemp(List<Curso> value) {
    _cursosUserModalTemp = value;
    notifyListeners();
  }

  String get imgCursoModal => _imgCursoModal;

  set imgCursoModal(String value) {
    _imgCursoModal = value;

    notifyListeners();
  }

  setcursoSelected(String value) {
    cursoSelected = value;
    notifyListeners();
  }

  String get descripcionCursoModal => _descripcionCursoModal;

  set descripcionCursoModal(String value) {
    _descripcionCursoModal = value;
    notifyListeners();
  }

  String get subtitleCursoModal => _subtitleCursoModal;

  set subtitleCursoModal(String value) {
    _subtitleCursoModal = value;
    notifyListeners();
  }

  String get nombreCursoModal => _nombreCursoModal;

  set nombreCursoModal(String value) {
    _nombreCursoModal = value;
    notifyListeners();
  }

  Curso get cursoModal => _cursoModal;

  set cursoModal(Curso value) {
    _cursoModal = value;
    notifyListeners();
  }

  int _total = 0;

  List<Curso> get allCursos => _allCursos;

  set allCursos(List<Curso> value) {
    _allCursos = value;
    notifyListeners();
  }

  int get total => _total;

  set total(int value) {
    _total = value;
    notifyListeners();
  }

  Curso get curso => _curso;
  set curso(Curso value) {
    _curso = value;
    notifyListeners();
  }

  bool isLoading = false;

  Future getCursoModal(id) async {
    await getAllCursos();
    try {
      final json = await JpApi.httpGet('/cursos/$id');
      final Curso curso = Curso.fromJson(json);
      cursoModal = curso;
      _imgCursoModal = curso.img;
      _descripcionCursoModal = curso.descripcion;
      _subtitleCursoModal = curso.subtitle;
      _nombreCursoModal = curso.nombre;

      notifyListeners();
    } catch (e) {
      throw 'Error';
    }
  }

  // funciones

  getCursosById(String id) async {
    try {
      final resp = await JpApi.httpGet('/cursos/$id');
      final cursosResponse = Curso.fromJson(resp);
      _cursoView = cursosResponse;
 
      notifyListeners();
      return _cursoView;
    } catch (e) {
      throw 'Error getCursosId';
    }
  }

  createCurso() {
    final data = {
      "nombre": _nombreCursoModal,
      "subtitle": _subtitleCursoModal,
      "descripcion": _descripcionCursoModal,
      "img": _imgCursoModal,
      "duracion": _duracionCursoModal,
    };

    JpApi.post('/cursos', data).then((json) {
      final curso = Curso.fromJson(json);
      _allCursos.add(curso);
      notifyListeners();
      NotificationServices.showSnackbarError('Curso Creado con exito', Colors.green);
    }).catchError((e) {
      NotificationServices.showSnackbarError('Error creando curso', Colors.red);
    });
  }

  getAllCursos() async {
    try {
      final resp = await JpApi.httpGet('/cursos');
      final cursosResponse = AllCursosResponse.fromJson(resp);
      _total = cursosResponse.total;
      _allCursos = cursosResponse.cursos;

      notifyListeners();
    } catch (e) {
      throw 'error $e';
    }
  }

  Curso obtenerCurso(String id) {
    try {
      final Curso newCurso = _allCursos.firstWhere((element) => element.id == id, orElse: () => curso);
      return newCurso;
    } catch (e) {
      rethrow;
    }
  }

  Future addCursoToUser({required BuildContext context, required String userId}) async {
    final resp = await JpApi.put('/usuarios/add/$userId', {"cursoId": cursoSelected});
    if (resp['msg'] != null) {
      // NotificationServices.showSnackbarError(resp['msg'], Colors.red);
      return;
    } else {
      NotificationServices.showSnackbarError('Curso agregado', Colors.green);
      notifyListeners();
    }
  }

  Future deleteCursoToUser({required String userId, required String cursoId}) async {
    try {
      await JpApi.put('/usuarios/remove/$userId', {"cursoId": cursoId});
      _cursosUserModalTemp.removeWhere((element) => element.id == cursoId);
      notifyListeners();
      NotificationServices.showSnackbarError('Curso Borrado', Colors.green);
    } catch (e) {
      throw 'error $e';
    }
  }

  Future updateCurso({
    required String uid,
  }) async {
    final data = {
      "nombre": _nombreCursoModal,
      "subtitle": _subtitleCursoModal,
      "descripcion": _descripcionCursoModal,
      "img": _imgCursoModal,
      "duracion": _duracionCursoModal,
    };

    try {
      final json = await JpApi.put('/cursos/$uid', data);

      curso = Curso.fromJson(json);

      _allCursos.removeWhere(
        (element) => element.id == uid,
      );

      _allCursos.add(curso);

      notifyListeners();
      NotificationServices.showSnackbarError('Curso Actualizado con exito', Colors.green);
    } catch (e) {
      NotificationServices.showSnackbarError('Error actualizando curso', Colors.red);
      throw Exception('Error Actualizando usuario.');
    }
  }

  Future deleteCurso(String id) async {
    try {
      await JpApi.delete('/cursos/$id', {});

      _allCursos.removeWhere(
        (curso) => curso.id == id,
      );

      notifyListeners();
      NotificationServices.showSnackbarError('Curso borrado con exito', Colors.green);
      return true;
    } catch (e) {
      NotificationServices.showSnackbarError('Error borrando curso', Colors.red);
    }
  }

  Future createModulo({
    required String nombre,
    required String video,
    required String descripcion,
    required String descarga,
    required String curso,
  }) async {
    final data = {"nombre": nombre, "descripcion": descripcion, "video": video, "descarga": descarga, "curso": curso};

    // Petición HTTP
    await JpApi.post('/modulos', data).then((json) {
      getAllCursos();
      notifyListeners();
      NotificationServices.showSnackbarError('Modulo agregado con exito', Colors.green);
    }).catchError((e) {
      NotificationServices.showSnackbarError('Error agregado modulo', Colors.red);
    });
  }

  Future deleteModulo(String id) async {
    try {
      await JpApi.delete('/modulos/$id', {});

      // await getCursoModal(id);

      _cursoModal.modulos.removeWhere((element) => element.id == id);
      getAllCursos();
      notifyListeners();
      NotificationServices.showSnackbarError('Modulo borrado con exito', Colors.green);
      return true;
    } catch (e) {
      NotificationServices.showSnackbarError('Error borrando modulo', Colors.red);
    }
  }

  Future createComent({
    required String comentario,
    required String cursoId,
    required String moduloId,
  }) async {
    final data = {"comentario": comentario, "cursoId": cursoId, "moduloId": moduloId};

    // Petición HTTP
    await JpApi.post('/modulos/coments/add', data).then((json) {
      getAllCursos();
      notifyListeners();
      NotificationServices.showSnackbarError('Comentario agregado con exito', Colors.green);
    }).catchError((e) {
      NotificationServices.showSnackbarError('Error agregado comentario', Colors.red);
    });
  }

  Future obtenerMisCursos(Usuario user) async {
    await getAllCursos();
    final List<Curso> misNewCursos = [];

    for (var e in user.cursos) {
      Curso? cursotmp = allCursos.where((element) => element.id == e).firstOrNull;

      if (!cursotmp.isNull) {
        misNewCursos.add(cursotmp!);
        _misCursos = misNewCursos;
      }
    }
  }

  Future createResp({required String id, required String respuesta}) async {
    try {
      await JpApi.post('/modulos/resp/add/$id', {"respuesta": respuesta});

    } catch (e) {
      throw 'Error $e';
    }
  }

  Future deleteComent({required String comentId, required String moduloId}) async {
    try {
      await JpApi.delete('/modulos/coments/$comentId', {"moduloId": moduloId});
    } catch (e) {
      throw 'Error $e';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/generated/l10n.dart';
import 'package:jp_director/models/certificado.dart';
import 'package:jp_director/services/notificacion_service.dart';

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

  Certificado _newCert = certDummy;

  String _nombreCursoModal = '';
  String _precioCursoModal = '';
  String _descripcionCursoModal = '';
  String _imgCursoModal = '';
  String _banerCursoModal = '';
  String _duracionCursoModal = '';
  String _urlImgCert = '';
  bool _publicadoCursoModal = true;
  bool _preorderCursoModal = false;
  String _estudiantesCursoModal = '0';

  // --------------------------------- //
  String get estudiantesCursoModal => _estudiantesCursoModal;

  set estudiantesCursoModal(String value) {
    _estudiantesCursoModal = value;
    notifyListeners();
  }

  Certificado get newCert => _newCert;

  set newCert(Certificado value) {
    _newCert = value;
    notifyListeners();
  }

  bool get preorderCursoModal => _preorderCursoModal;

  set preorderCursoModal(bool value) {
    _preorderCursoModal = value;
    notifyListeners();
  }

  bool get publicadoCursoModal => _publicadoCursoModal;

  set publicadoCursoModal(bool value) {
    _publicadoCursoModal = value;
    notifyListeners();
  }

  String get banerCursoModal => _banerCursoModal;

  set banerCursoModal(String value) {
    _banerCursoModal = value;
    notifyListeners();
  }

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

  String get urlImgCert => _urlImgCert;

  set urlImgCert(String value) {
    _urlImgCert = value;
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

  String get subtitleCursoModal => _precioCursoModal;

  set precioCursoModal(String value) {
    _precioCursoModal = value;
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
    // await getAllCursos();
    try {
      final json = await JpApi.httpGet('/cursos/$id');
      final Curso curso = Curso.fromJson(json);
      cursoModal = curso;
      _imgCursoModal = curso.img;
      _descripcionCursoModal = curso.descripcion;
      _precioCursoModal = curso.precio;
      _banerCursoModal = curso.baner;
      _duracionCursoModal = curso.duracion;
      _nombreCursoModal = curso.nombre;
      _urlImgCert = curso.urlImgCert;
      _estudiantesCursoModal = curso.totalEstudiantes;
      _publicadoCursoModal = curso.publicado;
      _preorderCursoModal = curso.preorder;

      notifyListeners();
    } catch (e) {
      throw 'Error';
    }
  }

  // funciones

  Future<Curso> getCursosById(String id) async {
    try {
      final resp = await JpApi.httpGet('/cursos/$id');
      final cursosResponse = Curso.fromJson(resp);
      _cursoView = cursosResponse;
      notifyListeners();
      return _cursoView;
    } catch (e) {
      throw 'Error getCursosById $e';
    }
  }

  createCurso(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final data = {
      "nombre": _nombreCursoModal,
      "precio": _precioCursoModal,
      "descripcion": _descripcionCursoModal,
      "img": _imgCursoModal,
      "baner": _banerCursoModal,
      "duracion": _duracionCursoModal,
      "urlImgCert": _urlImgCert,
      "publicado": _publicadoCursoModal,
      "preorder": _preorderCursoModal,
      "totalEstudiantes": _estudiantesCursoModal,
    };

    JpApi.post('/cursos', data).then((json) {
      final curso = Curso.fromJson(json);
      _allCursos.add(curso);
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.cursoCreado, Colors.green);
    }).catchError((e) {
      NotifServ.showSnackbarError(appLocal.errorCursoCreado, Colors.red);
    });
  }

  getAllCursos() async {
    try {
      final resp = await JpApi.httpGet('/cursos');
      
      // Verificar si la respuesta contiene un error
      if (resp is Map && resp['error'] == true) {
        print('Error en la respuesta del servidor: ${resp['mensaje']}');
        return; // No procesamos una respuesta con error
      }
      
      // Verificar que la respuesta es válida antes de procesarla
      if (resp != null) {
        final cursosResponse = AllCursosResponse.fromJson(resp);
        _total = cursosResponse.total;
        _allCursos = cursosResponse.cursos;
        notifyListeners();
      } else {
        print('La respuesta del servidor es nula');
      }
    } catch (e) {
      // En lugar de lanzar una excepción, manejamos el error y lo registramos
      print('Error al cargar cursos: $e');
      // Podríamos establecer un flag de error aquí si es necesario
      // _hasError = true;
      // notifyListeners();
    }
  }

  Curso obtenerCurso(String id) {
    try {
      // Verificamos si la lista está vacía para evitar errores
      if (_allCursos.isEmpty) {
        return _curso; // Usamos el curso dummy si no hay datos
      }
      
      // Buscamos el curso por ID con manejo seguro
      final Curso newCurso = _allCursos
          .firstWhere((element) => element.id == id, orElse: () => _curso);
      return newCurso;
    } catch (e) {
      // Registramos el error para depuración
      print('Error en obtenerCurso: $e');
      return _curso; // Devolvemos el curso dummy en caso de error
    }
  }

  Future addCursoToUser(
      {required BuildContext context, required String userId}) async {
    final appLocal = AppLocalizations.of(context);
    final resp =
        await JpApi.put('/usuarios/add/$userId', {"cursoId": cursoSelected});
    if (resp['msg'] != null) {
      // NotificationServices.showSnackbarError(resp['msg'], Colors.red);
      return;
    } else {
      NotifServ.showSnackbarError(appLocal.cursoAgregado, Colors.green);
      notifyListeners();
    }
  }

  Future deleteCursoToUser(
      {required BuildContext context,
      required String userId,
      required String cursoId}) async {
    final appLocal = AppLocalizations.of(context);
    try {
      await JpApi.put('/usuarios/remove/$userId', {"cursoId": cursoId});
      _cursosUserModalTemp.removeWhere((element) => element.id == cursoId);
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.cursoBorrado, Colors.green);
    } catch (e) {
      throw 'error $e';
    }
  }

  Future updateCurso(
      {required String uid, required BuildContext context}) async {
    final appLocal = AppLocalizations.of(context);
    final data = {
      "nombre": _nombreCursoModal,
      "precio": _precioCursoModal,
      "descripcion": _descripcionCursoModal,
      "img": _imgCursoModal,
      "baner": _banerCursoModal,
      "duracion": _duracionCursoModal,
      "urlImgCert": _urlImgCert,
      "publicado": _publicadoCursoModal,
      "preorder": _preorderCursoModal,
      "totalEstudiantes": _estudiantesCursoModal,
    };

    try {
      final json = await JpApi.put('/cursos/$uid', data);

      curso = Curso.fromJson(json);

      _allCursos.removeWhere(
        (element) => element.id == uid,
      );

      _allCursos.add(curso);

      notifyListeners();
      NotifServ.showSnackbarError(appLocal.cursoActualizado, Colors.green);
    } catch (e) {
      NotifServ.showSnackbarError(appLocal.errorCursoActualizado, Colors.red);
      throw Exception('Error Actualizando usuario.');
    }
  }

  Future deleteCurso(
      {required BuildContext context, required String id}) async {
    final appLocal = AppLocalizations.of(context);
    try {
      await JpApi.delete('/cursos/$id', {});

      _allCursos.removeWhere(
        (curso) => curso.id == id,
      );

      notifyListeners();
      NotifServ.showSnackbarError(appLocal.cursoBorrado, Colors.green);
      return true;
    } catch (e) {
      NotifServ.showSnackbarError(appLocal.errorEliminadoCurso, Colors.red);
    }
  }

  Future createModulo({
    required BuildContext context,
    required String nombre,
    required String video,
    required String descripcion,
    required String idDriveFolder,
    required String idDriveZip,
    required String curso,
  }) async {
    final appLocal = AppLocalizations.of(context);
    final data = {
      "nombre": nombre,
      "descripcion": descripcion,
      "video": video,
      "idDriveFolder": idDriveFolder,
      "idDriveZip": idDriveZip,
      "curso": curso,
    };

    // Petición HTTP
    await JpApi.post('/modulos', data).then((json) {
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.moduloAgregado, Colors.green);
    }).catchError((e) {
      NotifServ.showSnackbarError(appLocal.errorModuloAgregado, Colors.red);
    });
  }

  Future updateModulo({
    required BuildContext context,
    required String uid,
    required String nombreModulo,
    required String descripcionModulo,
    required String urlVideo,
    required String idDriveFolder,
    required String idDriveZip,
  }) async {
    final appLocal = AppLocalizations.of(context);
    final data = {
      "nombre": nombreModulo,
      "descripcion": descripcionModulo,
      "video": urlVideo,
      "idDriveFolder": idDriveFolder,
      "idDriveZip": idDriveZip,
    };

    try {
      await JpApi.put('/modulos/$uid', data);

      notifyListeners();
      NotifServ.showSnackbarError(appLocal.moduloActualizado, Colors.green);
    } catch (e) {
      NotifServ.showSnackbarError(appLocal.errorActualizandoModulo, Colors.red);
      // throw Exception('Error Actualizando modulo.');
    }
  }

  Future deleteModulo(
      {required BuildContext context, required String id}) async {
    final appLocal = AppLocalizations.of(context);

    try {
      await JpApi.delete('/modulos/$id', {});
      _cursoModal.modulos.removeWhere((element) => element.id == id);
      getAllCursos();
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.moduloBorrado, Colors.green);
      return true;
    } catch (e) {
      NotifServ.showSnackbarError(appLocal.errorBorrandoModulo, Colors.red);
    }
  }

  Future createComent({
    required BuildContext context,
    required String comentario,
    required String cursoId,
    required String moduloId,
  }) async {
    final appLocal = AppLocalizations.of(context);
    final data = {
      "comentario": comentario,
      "cursoId": cursoId,
      "moduloId": moduloId
    };

    // Petición HTTP
    await JpApi.post('/modulos/coments/add', data).then((json) {
      // getAllCursos();
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.comentarioAgregado, Colors.green);
    }).catchError((e) {
      NotifServ.showSnackbarError(
          appLocal.errorAgregandoComentario, Colors.red);
    });
  }

  Future obtenerMisCursos(Usuario user) async {
    // await getAllCursos();
    final List<Curso> misNewCursos = [];

    for (var e in user.cursos) {
      Curso? cursotmp =
          allCursos.where((element) => element.id == e).firstOrNull;

      if (cursotmp != null) {
        misNewCursos.add(cursotmp);
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

  Future deleteComent(
      {required String comentId, required String moduloId}) async {
    try {
      await JpApi.delete('/modulos/coments/$comentId', {"moduloId": moduloId});
    } catch (e) {
      throw 'Error $e';
    }
  }

  Future generarCert({required String userId, required String cursoId}) async {
    final data = {"userId": userId, "cursoId": cursoId};

    try {
      final res = await JpApi.post('/uploads/certificados/gen', data);
      _newCert = Certificado.fromJson(res["cert"]);
      notifyListeners();
      return;
    } catch (e) {
      return;
    }
  }

  Future createTestimonio({
    required BuildContext context,
    required String nombre,
    required String img,
    required String testimonio,
    required String curso,
  }) async {
    final appLocal = AppLocalizations.of(context);
    final data = {
      "nombre": nombre,
      "img": img,
      "testimonio": testimonio,
      "cursoId": curso,
    };
    // Petición HTTP
    await JpApi.post('/cursos/add/testimonio/$curso', data).then((json) {
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.testimonioAgregado, Colors.green);
    }).catchError((e) {
      NotifServ.showSnackbarError(appLocal.errorTestimonioAgregado, Colors.red);
    });
  }

  Future updateTestimonio({
    required BuildContext context,
    required String id,
    required String nombre,
    required String img,
    required String testimonio,
    required String curso,
  }) async {
    final appLocal = AppLocalizations.of(context);
    final data = {
      "nombre": nombre,
      "img": img,
      "testimonio": testimonio,
      "cursoId": curso,
    };

    try {
      await JpApi.put('/cursos/testimonio/$id', data);

      notifyListeners();
      NotifServ.showSnackbarError(appLocal.testimonioActualizado, Colors.green);
    } catch (e) {
      NotifServ.showSnackbarError(
          appLocal.errorTestimonioActualizado, Colors.red);
      // throw Exception('Error Actualizando modulo.');
    }
  }

  Future deleteTestimonio(
      {required BuildContext context, required String id}) async {
    final appLocal = AppLocalizations.of(context);
    try {
      await JpApi.delete('/cursos/testimonio/$id', {});

      // await getCursoModal(id);

      _cursoModal.testimonios.removeWhere((element) => element.id == id);
      getAllCursos();
      notifyListeners();
      NotifServ.showSnackbarError(appLocal.testimonioBorrado, Colors.green);
      return true;
    } catch (e) {
      NotifServ.showSnackbarError(appLocal.errorTestimonioBorrado, Colors.red);
    }
  }
}

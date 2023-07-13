import 'package:flutter/material.dart';

import '../../api/jp_api.dart';
import '../../models/curso.dart';
import '../../models/modulo.dart';

class CursoModalProvider extends ChangeNotifier {
  late Curso _modalCurso;

  late List<Modulo> _modulos = [];

  Curso get modalCurso => _modalCurso;

  set modalCurso(Curso value) {
    _modalCurso = value;
    _modulos = value.modulos.where((m) => m.estado).toList();
    notifyListeners();
  }

  List<Modulo> get modulos => _modulos;

  setmodulos() {
    _modulos = _modalCurso.modulos;
    notifyListeners();
  }

  getCurso(String id) async {
    try {
      final resp = await JpApi.httpGet('/cursos/$id');
      final curso = Curso.fromJson(resp);
      _modalCurso = curso;
      setmodulos();

      notifyListeners();
    } catch (e) {
      throw 'error $e';
    }
  }
}

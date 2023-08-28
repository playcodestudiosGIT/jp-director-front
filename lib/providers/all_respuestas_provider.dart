import 'package:flutter/material.dart';
import 'package:jp_director/models/resp.dart';

import '../api/jp_api.dart';
import '../models/http/all_respuestas_response.dart';

class AllRespuestasProvider extends ChangeNotifier {
  List<Resp> _allRespuestas = [];
  int _totalRespuestas = 0;

  /// ---- Getters y Setters =------ ///

  List<Resp> get allRespuestas => _allRespuestas;

  set allRespuestas(List<Resp> value) {
    _allRespuestas = value;
    notifyListeners();
  }

  int get totalRespuestas => _totalRespuestas;

  set totalRespuestas(int value) {
    _totalRespuestas = value;
    notifyListeners();
  }

  // --- Peticiones --- //

  Future getRespuesta() async {
    final json = await JpApi.httpGet('/modulos/resp/all');

    final respuestasResponse = AllRespuestasResponse.fromJson(json);

    _allRespuestas = respuestasResponse.respuestas;
    _totalRespuestas = respuestasResponse.total;
    notifyListeners();
  }

  Resp? getRespuestaId(respuestaId) {
    Resp? resp = _allRespuestas.where((element) => element.id == respuestaId).firstOrNull;

    if (resp != null) {
      return resp;
    } else {
      return null;
    }
  }
}

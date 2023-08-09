import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/models/http/baners_response.dart';

import '../api/jp_api.dart';
import '../models/baner.dart';
import '../services/notificacion_service.dart';

class BanersProvider extends ChangeNotifier {
  List<Baner> _baners = [];

  List<Baner> get baners => _baners;

  set baners(List<Baner> value) {
    _baners = value;
    notifyListeners();
  }

  getBaners() async {
    // 0 - 100
    final resp = await JpApi.httpGet('/baners');
    final banersResponse = BanersResponse.fromJson(resp);
    _baners = banersResponse.baners;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  Future updateBaner({
    required String uid,
    required String nombreBaner,
    required String priceId,
    required String cursoId,
  }) async {
    final data = {
      'nombre': nombreBaner,
      'priceId': priceId,
      'cursoId': cursoId,
    };
    try {
      final json = await JpApi.put('/baners/$uid', data);
      final baner = Baner.fromJson(json);

      _baners.removeWhere(
        (element) => element.id == uid,
      );

      _baners.add(baner);

      notifyListeners();
      NotifServ.showSnackbarError('Baner Actualizado con exito', Colors.green);
    } catch (e) {
      NotifServ.showSnackbarError('Error actualizando baner', Colors.red);
    }
  }

  createBaner({
    required String nombre,
    required String priceId,
    required String cursoId,
  }) async {
    final data = {
      'nombre': nombre,
      'priceId': priceId,
      'cursoId': cursoId,
    };
    // Petición HTTP
    await JpApi.post('/baners', data).then((json) {
      final baner = Baner.fromJson(json);
      baners.add(baner);
      notifyListeners();
    }).catchError((e) {
      NotifServ.showSnackbarError('Error creando Baner', Colors.red);
    });
  }

  Future deleteBaner(String id) async {
    try {
      await JpApi.delete('/baners/$id', {});

      _baners.removeWhere((element) => element.id == id);

      notifyListeners();
      NotifServ.showSnackbarError('Baner borrado con exito', Colors.green);
      return true;
    } catch (e) {
      NotifServ.showSnackbarError('Error borrando baner', Colors.red);
    }
  }
}

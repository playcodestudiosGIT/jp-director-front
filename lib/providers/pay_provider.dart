import 'package:flutter/material.dart';

import '../api/jp_api.dart';
import '../services/notificacion_service.dart';

class PayProvider extends ChangeNotifier {
  String _url = '';

  String get url => _url;

  set url(String value) {
    _url = value;
    notifyListeners();
  }

  Future<String> createSession({
    required int price,
    required String cursoId,
    required String userEmail,
  }) async {
    final data = {
      'price': price * 100,
      'cursoId': cursoId,
      'userEmail': userEmail,
    };
    try {
      await JpApi.post('/pay/create-session', data).then((json) {
        _url = json["url"];
      });
      return _url;
    } catch (e) {
      NotifServ.showSnackbarError('Error in session', Colors.red);
      return _url;
    }
  }

  Future<bool> checkPayAndAddCurso({
    required String cursoId,
    required String userId,
    required String sessionId,
  }) async {
    final data = {
      "sessionId": sessionId,
      "userId": userId,
      "cursoId": cursoId,
    };
    try {
      JpApi.post('/pay/getsession', data).toString();
      return true;
    } catch (e) {
      return false;
    }
  }
}

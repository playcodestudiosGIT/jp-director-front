import 'package:flutter/material.dart';
import 'package:jp_director/api/jp_api.dart';

class MetaEventProvider extends ChangeNotifier {
  Future<bool> regaloEvent(
      {required String email, required String phone}) async {
    try {
      final resp =
          await JpApi.post('/events/regalo', {"email": email, "phone": phone});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registroEvent(
      {required String email,
      required String name,
      required String lastname}) async {
    try {
      final resp = await JpApi.post('/events/registro',
          {"email": email, "name": name, "lastname": lastname});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clickEvent(
      {required String source, required String description}) async {
    try {
      final resp = await JpApi.post('/events/click', {
        "source": source,
        "description": description,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}

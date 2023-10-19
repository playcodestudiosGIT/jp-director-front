import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/api/jp_api.dart';

class EventsProvider extends ChangeNotifier {
  Future<bool> metaRegaloEvent(
      {required String email, required String phone}) async {
    try {
      await JpApi.post('/events/meta-regalo', {"email": email, "phone": phone});
      print('meta event creado');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> metaRegistroEvent(
      {required String email,
      required String name,
      required String lastname}) async {
    try {
      await JpApi.post('/events/meta-registro',
          {"email": email, "name": name, "lastname": lastname});
      print('meta event creado');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clickEvent(
      {required String source,
      required String description,
      required String title,
      String uid = '',
      String email = '',
      String phone = ''}) async {
    try {
      await JpApi.post('/events/meta-click', {
        "source": source,
        "description": description,
        "title": title,
        "email": email,
        "phone": phone
      });
      print('meta event creado');

      ///////////

      final hashUid = sha256.convert(utf8.encode(uid));
      final hashEmail = sha256.convert(utf8.encode(email));
      final hashPhone = sha256.convert(utf8.encode(phone));
      final data = {
        "source": source,
        "hashId": hashUid,
        "hashPhone": hashPhone,
        "hashEmail": hashEmail,
        "description": description,
        "title": title
      };
      await JpApi.post('/events/ttk-click-event', data);
      print('ttk event creado');
      return true;
    } catch (e) {
      return false;
    }
  }

  
}

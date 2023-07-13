import 'package:dio/dio.dart';

import '../services/local_storage.dart';


class BackendGoogle {
  static Dio dio = Dio();

  static void configureDio() {
    // base url
    dio.options.baseUrl = 'https://calendar-gcj32thyuq-uc.a.run.app';
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers = {'x-token': LocalStorage.prefs.getString('token')};
  }

  static Future httpGet(String path) async {
    try {
      final resp = await dio.get(path);
      return resp;
    } catch (e) {
      throw ('error en el GET -- Google api dio');
    }
  }

  static Future post(String path, data) async {
    try {
      final resp = await dio.post(path, data: data);
      return resp;
    } catch (e) {
      throw ('error en el GET -- Google api dio');
    }
  }
}

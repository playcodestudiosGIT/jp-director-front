import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../services/local_storage.dart';

class JpApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    //base Url
    _dio.options.baseUrl =
    // 'https://www.jpdirector.net/api';
    'http://localhost:8080/api';

    //Configure headers
    _dio.options.headers = {'x-token': LocalStorage.prefs.get('token') ?? ''};
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      throw ('GET-Error en la conexión $e');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } catch (e) {
      throw ('POST-Error en la conexión $e');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } catch (e) {
      throw ('PUT-Error conexión $e');
    }
  }
  
  static Future putJson(String path, Map<String, dynamic> data) async {
    try {
      final resp = await _dio.put(path, data: data);
      return resp.data;
    } catch (e) {
      throw ('PUT-JSON-Error conexión $e');
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } catch (e) {
      throw ('DELETE-Error conexion $e');
    }
  }

  static Future editUserImg(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put(path, data: formData);
      return resp;
    } on DioException catch (e) {
      throw ('PUT-Error ACT IMG USER $e');
    }
  }

  static Future editBanerImg(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put(path, data: formData);
      return resp;
    } on DioException catch (e) {
      throw ('PUT-Error ACT IMG BANER $e');
    }
  }

  static Future editBlogImage(String id, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put('/uploads/blogs/$id', data: formData);
      // El backend puede devolver directamente la URL o un objeto con la URL
      if (resp.data is String) {
        return resp.data; // Si es directamente la URL
      } else if (resp.data is Map<String, dynamic>) {
        // Si es un objeto con la URL, intentamos obtener el valor del campo 'img'
        return resp.data['img'] ?? resp.data['imagen'] ?? resp.data['url'] ?? resp.data;
      }
      return resp.data;
    } on DioException catch (e) {
      throw ('PUT-Error al actualizar imagen del blog: $e');
    }
  }
}

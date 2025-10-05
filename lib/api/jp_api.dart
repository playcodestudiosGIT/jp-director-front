import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../services/local_storage.dart';

class JpApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    //base Url
    _dio.options.baseUrl =
    'https://www.jpdirector.net/api';
    // 'http://localhost:8080/api';

    //Configure headers
    _dio.options.headers = {'x-token': LocalStorage.prefs.get('token') ?? ''};
    
    // Configuración de timeouts globales
    _dio.options.connectTimeout = const Duration(seconds: 5); // Tiempo de conexión
    _dio.options.receiveTimeout = const Duration(seconds: 8); // Tiempo para recibir datos
    
    // Solo configuramos sendTimeout si no estamos en plataforma web
    if (!kIsWeb) {
      _dio.options.sendTimeout = const Duration(seconds: 5);    // Tiempo para enviar datos
    }
    
    // Interceptor para manejar errores de forma personalizada
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // Crear un mensaje de error apropiado según el tipo de error
          String mensaje = 'Error de conexión desconocido';
          
          // Manejar diferentes tipos de errores con mensajes personalizados
          switch (e.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.sendTimeout:
              mensaje = 'El servidor está tardando demasiado en responder. Por favor, inténtelo más tarde.';
              break;
            case DioExceptionType.connectionError:
              mensaje = 'No se pudo conectar con el servidor. Verifique su conexión a Internet.';
              break;
            case DioExceptionType.badResponse:
              mensaje = 'El servidor respondió con un error: ${e.response?.statusCode}';
              break;
            default:
              mensaje = 'Error al comunicarse con el servidor: ${e.message}';
          }
          
          // En lugar de propagar el error, devolvemos una respuesta estructurada
          // que las funciones pueden manejar sin bloquear la UI
          return handler.resolve(
            Response(
              requestOptions: e.requestOptions,
              data: {
                'error': true,
                'mensaje': mensaje,
                'tipo': e.type.toString(),
                'detalles': e.message
              },
              statusCode: e.response?.statusCode ?? 500,
            )
          );
        },
      ),
    );
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      // Verificar si la respuesta contiene un error (del interceptor)
      if (resp.data is Map && resp.data['error'] == true) {
        // No lanzamos excepción, devolvemos los datos estructurados para que la UI pueda manejarlos
        return resp.data;
      }
      return resp.data;
    } catch (e) {
      // Si por alguna razón el interceptor no capturó el error, creamos una estructura similar
      return {
        'error': true,
        'mensaje': 'Error de conexión: no se pudo completar la solicitud',
        'detalles': e.toString()
      };
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);
      // Verificar si la respuesta contiene un error (del interceptor)
      if (resp.data is Map && resp.data['error'] == true) {
        // No lanzamos excepción, devolvemos los datos estructurados
        return resp.data;
      }
      return resp.data;
    } catch (e) {
      // Si por alguna razón el interceptor no capturó el error, creamos una estructura similar
      return {
        'error': true,
        'mensaje': 'Error de conexión: no se pudo completar la solicitud',
        'detalles': e.toString()
      };
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.put(path, data: formData);
      // Verificar si la respuesta contiene un error (del interceptor)
      if (resp.data is Map && resp.data['error'] == true) {
        // No lanzamos excepción, devolvemos los datos estructurados
        return resp.data;
      }
      return resp.data;
    } catch (e) {
      // Si por alguna razón el interceptor no capturó el error, creamos una estructura similar
      return {
        'error': true,
        'mensaje': 'Error de conexión: no se pudo completar la solicitud',
        'detalles': e.toString()
      };
    }
  }
  
  static Future putJson(String path, Map<String, dynamic> data) async {
    try {
      final resp = await _dio.put(path, data: data);
      // Verificar si la respuesta contiene un error (del interceptor)
      if (resp.data is Map && resp.data['error'] == true) {
        // No lanzamos excepción, devolvemos los datos estructurados
        return resp.data;
      }
      return resp.data;
    } catch (e) {
      // Si por alguna razón el interceptor no capturó el error, creamos una estructura similar
      return {
        'error': true,
        'mensaje': 'Error de conexión: no se pudo completar la solicitud',
        'detalles': e.toString()
      };
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      // Verificar si la respuesta contiene un error (del interceptor)
      if (resp.data is Map && resp.data['error'] == true) {
        // No lanzamos excepción, devolvemos los datos estructurados
        return resp.data;
      }
      return resp.data;
    } catch (e) {
      // Si por alguna razón el interceptor no capturó el error, creamos una estructura similar
      return {
        'error': true,
        'mensaje': 'Error de conexión: no se pudo completar la solicitud',
        'detalles': e.toString()
      };
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

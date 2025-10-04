import '../api/jp_api.dart';
import '../models/blog.dart';
import '../models/http/all_blogs_response.dart';

class BlogService {
  // Obtener todos los blogs
  static Future<AllBlogsResponse> getAllBlogs() async {
    try {
      final json = await JpApi.httpGet('/blogs');
      return AllBlogsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // Obtener blogs publicados/activos
  static Future<AllBlogsResponse> getPublishedBlogs() async {
    try {
      final json = await JpApi.httpGet('/blogs/published');
      return AllBlogsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // Obtener blog por ID
  static Future<Blog> getBlogById(String id) async {
    try {
      final json = await JpApi.httpGet('/blogs/$id');
      return Blog.fromJson(json['blog']);
    } catch (e) {
      rethrow;
    }
  }

  // Crear nuevo blog
  static Future<Map<String, dynamic>> createBlog({
    required String tituloEs,
    required String tituloEn,
    required String contenidoEs,
    required String contenidoEn,
    required String imagen,
    required bool estado,
    required DateTime fechaPublicacion,
  }) async {
    try {
      final data = {
        'titulo_es': tituloEs,
        'titulo_en': tituloEn,
        'contenido_es': contenidoEs,
        'contenido_en': contenidoEn,
        'imagen': imagen,
        'estado': estado,
        'fecha_publicacion': fechaPublicacion.toIso8601String(),
      };
      
      final json = await JpApi.post('/blogs', data);
      return json;
    } catch (e) {
      rethrow;
    }
  }

  // Actualizar blog
  static Future<Map<String, dynamic>> updateBlog({
    required String id,
    required String tituloEs,
    required String tituloEn,
    required String contenidoEs,
    required String contenidoEn,
    required String imagen,
    required bool estado,
    required DateTime fechaPublicacion,
  }) async {
    try {
      final data = {
        'titulo_es': tituloEs,
        'titulo_en': tituloEn,
        'contenido_es': contenidoEs,
        'contenido_en': contenidoEn,
        'imagen': imagen,
        'estado': estado,
        'fecha_publicacion': fechaPublicacion.toIso8601String(),
      };
      
      final json = await JpApi.put('/blogs/$id', data);
      return json;
    } catch (e) {
      rethrow;
    }
  }

  // Eliminar blog
  static Future<Map<String, dynamic>> deleteBlog(String id) async {
    try {
      final json = await JpApi.delete('/blogs/$id', {});
      return json;
    } catch (e) {
      rethrow;
    }
  }

  // Buscar blogs por término
  static Future<AllBlogsResponse> searchBlogs(String searchTerm) async {
    try {
      final json = await JpApi.httpGet('/blogs/search?q=$searchTerm');
      return AllBlogsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // Obtener blogs por páginas (paginación)
  static Future<AllBlogsResponse> getBlogsPaginated({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final json = await JpApi.httpGet('/blogs?page=$page&limit=$limit');
      return AllBlogsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}





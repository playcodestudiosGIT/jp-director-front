import 'package:flutter/material.dart';

import '../api/jp_api.dart';
import '../models/blog.dart';
import '../models/http/all_blogs_response.dart';
import '../services/notificacion_service.dart';

class AllBlogsProvider extends ChangeNotifier {
  List<Blog> _allBlogs = [];

  Blog _blogModal = blogDummy;
  Blog _blog = blogDummy;
  Blog _blogView = blogDummy;

  String _tituloEsBlogModal = '';
  String _tituloEnBlogModal = '';
  String _contenidoEsBlogModal = '';
  String _contenidoEnBlogModal = '';
  String _imagenBlogModal = '';
  bool _publicadoBlogModal = true;
  DateTime _fechaPublicacionBlogModal = DateTime.now();

  // Para manejar blogs relacionados
  List<Blog> _blogsDisponiblesParaRelacionar = [];
  List<String> _idsRelacionados = [];

  // Getters y Setters para blogs relacionados
  List<String> get idsRelacionados => _idsRelacionados;
  set idsRelacionados(List<String> value) {
    _idsRelacionados = value;
    // notifyListeners();
  }

  List<Blog> get blogsDisponiblesParaRelacionar =>
      _blogsDisponiblesParaRelacionar;
  set blogsDisponiblesParaRelacionar(List<Blog> value) {
    _blogsDisponiblesParaRelacionar = value;
    // notifyListeners();
  }

  // Getters y Setters
  List<Blog> get allBlogs => _allBlogs;
  set allBlogs(List<Blog> value) {
    _allBlogs = value;
    // notifyListeners();
  }

  Blog get blogModal => _blogModal;
  set blogModal(Blog value) {
    _blogModal = value;
    // notifyListeners();
  }

  Blog get blog => _blog;
  set blog(Blog value) {
    _blog = value;
    // notifyListeners();
  }

  Blog get blogView => _blogView;
  set blogView(Blog value) {
    _blogView = value;
    // notifyListeners();
  }

  String get tituloEsBlogModal => _tituloEsBlogModal;
  set tituloEsBlogModal(String value) {
    _tituloEsBlogModal = value;
    // notifyListeners();
  }

  String get tituloEnBlogModal => _tituloEnBlogModal;
  set tituloEnBlogModal(String value) {
    _tituloEnBlogModal = value;
    // notifyListeners();
  }

  String get contenidoEsBlogModal => _contenidoEsBlogModal;
  set contenidoEsBlogModal(String value) {
    _contenidoEsBlogModal = value;
    // notifyListeners();
  }

  String get contenidoEnBlogModal => _contenidoEnBlogModal;
  set contenidoEnBlogModal(String value) {
    _contenidoEnBlogModal = value;
    // notifyListeners();
  }

  String get imagenBlogModal => _imagenBlogModal;
  set imagenBlogModal(String value) {
    _imagenBlogModal = value;
    // notifyListeners();
  }

  bool get publicadoBlogModal => _publicadoBlogModal;
  set publicadoBlogModal(bool value) {
    _publicadoBlogModal = value;
    // notifyListeners();
  }

  DateTime get fechaPublicacionBlogModal => _fechaPublicacionBlogModal;
  set fechaPublicacionBlogModal(DateTime value) {
    _fechaPublicacionBlogModal = value;
    // notifyListeners();
  }

  int _total = 0;
  int get total => _total;
  set total(int value) {
    _total = value;
    // notifyListeners();
  }

  bool isLoading = false;

  // Métodos del API

  // Obtener todos los blogs Sin NotifyListeners
  Future getAllBlogsSN() async {
    try {
      isLoading = true;

      print('Recargando lista de blogs silenciosamente...');

      // Añadir try/catch adicional para manejar posibles errores específicos
      try {
        final json = await JpApi.httpGet('/blogs');

        // Verificar si la respuesta es válida
        if (json == null) {
          throw Exception('Respuesta vacía del servidor');
        }

        // Intentar diferentes formatos de respuesta (sin imprimir toda la respuesta)
        if (json is Map<String, dynamic> && json.containsKey('blogs')) {
          // Formato esperado: { blogs: [...], total: X }
          _allBlogs =
              List<Blog>.from(json['blogs'].map((blog) => Blog.fromJson(blog)));
          _total = json['total'] ?? 0;
        } else if (json is List) {
          // Formato alternativo: directamente un array de blogs
          _allBlogs = List<Blog>.from(json.map((blog) => Blog.fromJson(blog)));
          _total = json.length;
        } else {
          // Intentar como AllBlogsResponse
          final AllBlogsResponse resp = AllBlogsResponse.fromJson(json);
          _allBlogs = resp.blogs;
          _total = resp.total;
        }

        print('Blogs cargados silenciosamente: ${_allBlogs.length}');
      } catch (innerError) {
        print('Error específico en getAllBlogsSN: $innerError');
      } finally {
        // Importante: restablecer isLoading a false
        isLoading = false;
      }
    } catch (e) {
      print('Error general en getAllBlogsSN: $e');
      isLoading = false;
    }
  }

  // Obtener todos los blogs
  Future getAllBlogs() async {
    try {
      isLoading = true;
      // notifyListeners();

      print('Recargando lista de blogs...');

      // Añadir try/catch adicional para manejar posibles errores específicos
      try {
        final json = await JpApi.httpGet('/blogs');

        // Verificar si la respuesta es válida
        if (json == null) {
          throw Exception('Respuesta vacía del servidor');
        }

        print('Respuesta de getAllBlogs: $json');

        // Intentar diferentes formatos de respuesta
        if (json is Map<String, dynamic> && json.containsKey('blogs')) {
          // Formato esperado: { blogs: [...], total: X }
          print('Formato de respuesta: objeto con campo blogs');
          _allBlogs =
              List<Blog>.from(json['blogs'].map((blog) => Blog.fromJson(blog)));
          _total = json['total'] ?? 0;
        } else if (json is List) {
          // Formato alternativo: directamente un array de blogs
          print('Formato de respuesta: array de blogs');
          _allBlogs = List<Blog>.from(json.map((blog) => Blog.fromJson(blog)));
          _total = json.length;
        } else {
          // Intentar como AllBlogsResponse
          print('Intentando procesar como AllBlogsResponse...');
          final AllBlogsResponse resp = AllBlogsResponse.fromJson(json);
          _allBlogs = resp.blogs;
          _total = resp.total;
        }

        print('Blogs cargados: ${_allBlogs.length}');
      } catch (innerError) {
        print('Error específico en getAllBlogs: $innerError');

        // Si hay un error de decodificación, intentamos obtener los datos de forma manual
        if (innerError.toString().contains('UTF-8')) {
          NotifServ.showSnackbarError(
              'Error de codificación. Mostrando datos disponibles.',
              Colors.orange);
          // Podríamos implementar una carga alternativa aquí si es necesario
        } else {
          throw innerError; // Re-lanzamos el error para el manejo externo
        }
      }

      isLoading = false;
      // notifyListeners();
    } catch (e) {
      print('Error general en getAllBlogs: $e');
      isLoading = false;
      // notifyListeners();
      NotifServ.showSnackbarError('Error al cargar blogs: $e', Colors.red);
    }
  }

  // Obtener blog por ID para modal/edición
  Future getBlogModal(String id) async {
    try {
      final json = await JpApi.httpGet('/blogs/$id');

      // Verificamos la estructura de la respuesta
      Blog blog;

      if (json == null) {
        throw Exception('Respuesta vacía del servidor');
      }

      // Si el json contiene directamente los datos del blog
      if (json is Map<String, dynamic> && json.containsKey('_id')) {
        blog = Blog.fromJson(json);
      }
      // Si el json tiene un campo 'blog' que contiene los datos
      else if (json is Map<String, dynamic> &&
          json.containsKey('blog') &&
          json['blog'] != null) {
        blog = Blog.fromJson(json['blog']);
      }
      // Si el json tiene un campo 'data' que contiene los datos
      else if (json is Map<String, dynamic> && json.containsKey('data')) {
        var data = json['data'];
        // Si data es un objeto
        if (data is Map<String, dynamic>) {
          blog = Blog.fromJson(data);
        }
        // Si data es una lista, tomamos el primer elemento
        else if (data is List && data.isNotEmpty) {
          blog = Blog.fromJson(data[0]);
        } else {
          print('Estructura de data inesperada: $data');
          throw Exception('Formato de data no reconocido');
        }
      }
      // Otra estructura de respuesta posible
      else {
        print('Estructura de respuesta JSON inesperada: $json');
        throw Exception('Formato de respuesta no reconocido');
      }

      blogModal = blog;
      _tituloEsBlogModal = blog.tituloEs;
      _tituloEnBlogModal = blog.tituloEn;
      _contenidoEsBlogModal = blog.contenidoEs;
      _contenidoEnBlogModal = blog.contenidoEn;
      _imagenBlogModal = blog.img; // Actualizado de imagen a img
      _publicadoBlogModal = blog.publicado;
      _fechaPublicacionBlogModal = blog.fechaPublicacion;

      // notifyListeners();
    } catch (e) {
      print('Error al cargar blog para edición: $e');
      NotifServ.showSnackbarError('Error al cargar blog: $e', Colors.red);
      // Inicializamos con valores por defecto en caso de error
      cleanBlogModal();
    }
  }

  // Obtener blog por ID para vista
  Future<Blog> getBlogById(String id) async {
    try {
      // Primero intentamos el endpoint directo
      try {
        final json = await JpApi.httpGet('/blogs/$id');

        // Verificamos el formato de la respuesta
        if (json != null) {
          Blog blog;

          // Si el json contiene directamente los datos del blog (sin campo 'blog')
          if (json is Map<String, dynamic> && json.containsKey('_id')) {
            blog = Blog.fromJson(json);
            print('Blog cargado con ID: ${blog.id}');

            // Verificamos si contiene blogs relacionados en la respuesta
            if (blog.relacionados.isEmpty) {
              print(
                  'No se encontraron blogs relacionados en la respuesta, intentando obtenerlos por endpoint específico');
              try {
                // Intentamos obtener los blogs relacionados por el endpoint específico
                final relacionados = await getBlogsRelacionados(id);
                if (relacionados.isNotEmpty) {
                  // Creamos una copia del blog con los relacionados
                  blog = blog.copyWith(relacionados: relacionados);
                }
              } catch (relError) {
                print(
                    'Error al obtener blogs relacionados adicionales: $relError');
                // Continuamos con el blog sin relacionados
              }
            } else {
              print(
                  'Blog incluye ${blog.relacionados.length} blogs relacionados');
            }
          }
          // Si el json tiene un campo 'blog' que contiene los datos
          else if (json is Map<String, dynamic> &&
              json.containsKey('blog') &&
              json['blog'] != null) {
            blog = Blog.fromJson(json['blog']);

            // Mismo procedimiento para los relacionados
            if (blog.relacionados.isEmpty) {
              try {
                final relacionados = await getBlogsRelacionados(id);
                if (relacionados.isNotEmpty) {
                  blog = blog.copyWith(relacionados: relacionados);
                }
              } catch (relError) {
                print(
                    'Error al obtener blogs relacionados adicionales: $relError');
              }
            }
          } else {
            throw Exception('Formato de respuesta no reconocido');
          }

          blogView = blog;
          return blog;
        } else {
          throw Exception('Respuesta vacía del servidor');
        }
      } catch (e) {
        // Si falla el endpoint directo, buscamos en la lista de blogs publicados
        print('Endpoint directo falló, buscando en lista: $e');

        // Intentar encontrar el blog en la lista de blogs publicados usando método silencioso
        final publishedBlogs = await getPublishedBlogsSN();
        final blog = publishedBlogs.firstWhere(
          (blog) => blog.id == id,
          orElse: () => blogDummy,
        );

        if (blog.id.isNotEmpty) {
          // Verificación más segura que comparar con blogDummy
          // Intentamos agregar los blogs relacionados
          try {
            final relacionados = await getBlogsRelacionados(id);
            if (relacionados.isNotEmpty) {
              final blogConRelacionados =
                  blog.copyWith(relacionados: relacionados);
              blogView = blogConRelacionados;
              return blogConRelacionados;
            }
          } catch (relError) {
            print('Error al obtener blogs relacionados: $relError');
          }

          blogView = blog;
          return blog;
        } else {
          throw Exception('Blog no encontrado');
        }
      }
    } catch (e) {
      NotifServ.showSnackbarError('Error al cargar blog: $e', Colors.red);
      throw e; // Propagar el error para que pueda ser manejado en la UI
    }
  }

  // Crear nuevo blog
  Future<bool> createBlog() async {
    try {
      print('Iniciando createBlog');
      print('Validando datos del formulario...');

      // Validación previa de datos
      if (_tituloEsBlogModal.isEmpty || _tituloEnBlogModal.isEmpty) {
        print('Error: Títulos vacíos');
        NotifServ.showSnackbarError('Los títulos son obligatorios', Colors.red);
        return false;
      }

      if (_contenidoEsBlogModal.isEmpty || _contenidoEnBlogModal.isEmpty) {
        print('Error: Contenidos vacíos');
        NotifServ.showSnackbarError('El contenido es obligatorio', Colors.red);
        return false;
      }

      // Asegurarse de que todos los textos estén sanitizados para evitar problemas de codificación
      final safeTextEs = Blog.sanitizeText(_tituloEsBlogModal);
      final safeTextEn = Blog.sanitizeText(_tituloEnBlogModal);
      final safeContentEs = Blog.sanitizeText(_contenidoEsBlogModal);
      final safeContentEn = Blog.sanitizeText(_contenidoEnBlogModal);

      // Formatear la fecha correctamente
      final formattedDate = _fechaPublicacionBlogModal.toIso8601String();
      print('Fecha formateada: $formattedDate');

      // Según la documentación de la API que compartiste, el backend espera el estado como booleano
      print(
          'Preparando estado para createBlog: $_publicadoBlogModal (tipo: ${_publicadoBlogModal.runtimeType})');

      final data = {
        'tituloEs': safeTextEs,
        'tituloEn': safeTextEn,
        'contenidoEs': safeContentEs,
        'contenidoEn': safeContentEn,
        'img': _imagenBlogModal.isEmpty  // Actualizado de 'imagen' a 'img'
            ? 'https://res.cloudinary.com/dqhj9cim6/image/upload/v1685068240/system/no-image_yvvpny.jpg'
            : _imagenBlogModal,
        'publicado':
            _publicadoBlogModal, // Enviamos el booleano tal como lo espera la API
        'fechaPublicacion': formattedDate,
      };

      print('Datos a enviar: $data');

      try {
        print('Enviando solicitud POST a /blogs');
        print('Payload JSON: ${data.toString()}');

        // Intentar enviar la solicitud con manejo específico de errores HTTP
        final json = await JpApi.post('/blogs', data);
        print('Respuesta recibida: $json');

        if (json == null) {
          print('Error: Respuesta nula del servidor');
          NotifServ.showSnackbarError(
              'Error: No se recibió respuesta del servidor', Colors.red);
          return false;
        }

        // Verificar si la respuesta es un objeto blog o un objeto con ok=true
        if ((json is Map<String, dynamic> && json['ok'] == true) ||
            (json is Map<String, dynamic> &&
                (json.containsKey('_id') || json.containsKey('id')))) {
          print('Blog creado exitosamente');
          NotifServ.showSnackbarError('Blog creado exitosamente', Colors.green);
          await getAllBlogs(); // Recargar lista

          // Limpiar formulario explícitamente y notificar listeners
          _blogModal = blogDummy;
          _tituloEsBlogModal = '';
          _tituloEnBlogModal = '';
          _contenidoEsBlogModal = '';
          _contenidoEnBlogModal = '';
          _imagenBlogModal = '';

          _fechaPublicacionBlogModal = DateTime.now();
          // notifyListeners();

          return true;
        } else {
          String errorMsg = 'Error al crear blog';
          if (json is Map<String, dynamic> && json['msg'] != null) {
            errorMsg = json['msg'];
          }
          print('Error en la respuesta: $errorMsg');
          NotifServ.showSnackbarError(errorMsg, Colors.red);
          return false;
        }
      } catch (innerError) {
        print('Error interno en la llamada POST: $innerError');
        NotifServ.showSnackbarError(
            'Error de comunicación: $innerError', Colors.red);
        return false;
      }
    } catch (e) {
      print('Error general en createBlog: $e');
      NotifServ.showSnackbarError('Error al crear blog: $e', Colors.red);
      return false;
    }
  }

  // Actualizar blog existente
  Future<bool> updateBlog(String id) async {
    if (id.isEmpty) {
      print('Error: ID vacío al intentar actualizar un blog');
      NotifServ.showSnackbarError('Error: ID de blog no válido', Colors.red);
      return false;
    }

    try {
      print('Iniciando updateBlog con ID: $id');
      print(
          'Valores actuales: titulo=${_tituloEsBlogModal}, publicado=${_publicadoBlogModal}, fecha=${_fechaPublicacionBlogModal}');

      // Validar datos críticos antes de enviar
      if (_tituloEsBlogModal.isEmpty || _tituloEnBlogModal.isEmpty) {
        NotifServ.showSnackbarError(
            'Error: Títulos no pueden estar vacíos', Colors.red);
        return false;
      }

      // Sanitizar todos los textos para evitar problemas de codificación
      final safeTextEs = Blog.sanitizeText(_tituloEsBlogModal);
      final safeTextEn = Blog.sanitizeText(_tituloEnBlogModal);
      final safeContentEs = Blog.sanitizeText(_contenidoEsBlogModal);
      final safeContentEn = Blog.sanitizeText(_contenidoEnBlogModal);

      // Formatear la fecha correctamente
      final formattedDate = _fechaPublicacionBlogModal.toIso8601String();
      print('Fecha formateada para actualización: $formattedDate');

      // Preparar datos para enviar con nombres exactos que espera el backend
      print(
          'Preparando estado para API: $_publicadoBlogModal (tipo: ${_publicadoBlogModal.runtimeType})');

      final data = {
        'tituloEs': safeTextEs,
        'tituloEn': safeTextEn,
        'contenidoEs': safeContentEs,
        'contenidoEn': safeContentEn,
        'img': _imagenBlogModal, // Actualizado de 'imagen' a 'img'
        'publicado': _publicadoBlogModal,
        'fechaPublicacion': formattedDate,
      };

      print('Enviando datos para actualizar: $data');
      try {
        print('Enviando solicitud PUT a /blogs/$id');
        print('Payload JSON: ${data.toString()}');

        // Intentar enviar la solicitud con manejo específico de errores HTTP
        final json = await JpApi.put('/blogs/$id', data);
        print('Respuesta del servidor: $json');

        if (json == null) {
          print('Error: Respuesta nula del servidor en updateBlog');
          NotifServ.showSnackbarError(
              'Error: No se recibió respuesta del servidor', Colors.red);
          return false;
        }

        // Verificar si la respuesta es un objeto blog (tiene _id y tituloEs)
        if (json is Map<String, dynamic> &&
            (json.containsKey('_id') || json.containsKey('id'))) {
          print(
              'Blog actualizado correctamente, ID: ${json['_id'] ?? json['id']}');
          NotifServ.showSnackbarError(
              'Blog actualizado exitosamente', Colors.green);
          await getAllBlogs(); // Recargar lista

          // Limpiar formulario explícitamente y notificar listeners
          _blogModal = blogDummy;
          _tituloEsBlogModal = '';
          _tituloEnBlogModal = '';
          _contenidoEsBlogModal = '';
          _contenidoEnBlogModal = '';
          _imagenBlogModal = '';

          _fechaPublicacionBlogModal = DateTime.now();
          // notifyListeners();

          return true;
        } else {
          String errorMsg = 'Error al actualizar blog';
          if (json is Map<String, dynamic> && json['msg'] != null) {
            errorMsg = json['msg'];
          }
          print('Error en respuesta: $errorMsg');
          NotifServ.showSnackbarError(errorMsg, Colors.red);
          return false;
        }
      } catch (innerError) {
        print('Error interno en la llamada al API: $innerError');
        NotifServ.showSnackbarError(
            'Error en la comunicación con el servidor: $innerError',
            Colors.red);
        return false;
      }
    } catch (e) {
      print('Error detallado al actualizar blog: $e');
      NotifServ.showSnackbarError('Error al actualizar blog: $e', Colors.red);
      return false;
    }
  }

  // Eliminar blog
  Future<bool> deleteBlog(String id) async {
    try {
      print('Intentando eliminar blog con ID: $id');
      final json = await JpApi.delete('/blogs/$id', {});

      // Verificar si la respuesta contiene datos del blog (lo que indica que fue encontrado)
      if (json != null &&
          json is Map<String, dynamic> &&
          (json.containsKey('_id') || json.containsKey('id'))) {
        print('Respuesta del servidor recibida: $json');
        // La API devuelve el blog eliminado, lo que consideramos exitoso
        NotifServ.showSnackbarError(
            'Blog eliminado exitosamente', Colors.green);
        await getAllBlogs(); // Recargar lista
        return true;
      } else if (json != null &&
          json is Map<String, dynamic> &&
          json['ok'] == true) {
        // Formato alternativo de respuesta exitosa
        NotifServ.showSnackbarError(
            'Blog eliminado exitosamente', Colors.green);
        await getAllBlogs(); // Recargar lista
        return true;
      } else {
        // Manejar caso de error
        String errorMsg = 'Error al eliminar blog';
        if (json is Map<String, dynamic> && json['msg'] != null) {
          errorMsg = json['msg'];
        }
        print('Error al eliminar blog: $errorMsg');
        NotifServ.showSnackbarError(errorMsg, Colors.red);
        return false;
      }
    } catch (e) {
      print('Error detallado al eliminar blog: $e');
      NotifServ.showSnackbarError('Error al eliminar blog: $e', Colors.red);
      return false;
    }
  }

  // Obtener blogs publicados (activos) para el frontend
  Future<List<Blog>> getPublishedBlogs() async {
    try {
      // Primero intentamos obtener los blogs publicados usando el endpoint específico
      final json = await JpApi.httpGet('/blogs');

      if (json != null) {
        List<Blog> allLoadedBlogs = [];

        // Si el servidor devuelve directamente una lista de blogs (sin envoltorio)
        if (json is List) {
          allLoadedBlogs = List<Blog>.from(json.map((x) => Blog.fromJson(x)));
        }
        // Si el servidor envuelve los blogs en un objeto con campo 'blogs'
        else if (json is Map<String, dynamic> && json.containsKey('blogs')) {
          allLoadedBlogs =
              List<Blog>.from(json['blogs'].map((x) => Blog.fromJson(x)));
        }

        // Filtramos explícitamente para mostrar SOLO blogs con publicado=true
        _allBlogs =
            allLoadedBlogs.where((blog) => blog.publicado == true).toList();

        // notifyListeners();
        return _allBlogs;
      } else {
        throw Exception('Respuesta vacía del servidor');
      }
    } catch (e) {
      NotifServ.showSnackbarError(
          'Error al cargar blogs publicados: $e', Colors.red);
      _allBlogs = [];
      // notifyListeners();
      throw e; // Propagar el error para que FutureBuilder pueda detectarlo
    }
  }
  
  // Versión silenciosa para usar durante la construcción de widgets
  Future<List<Blog>> getPublishedBlogsSN() async {
    try {
      // Primero intentamos obtener los blogs publicados usando el endpoint específico
      final json = await JpApi.httpGet('/blogs');

      if (json != null) {
        List<Blog> allLoadedBlogs = [];

        // Si el servidor devuelve directamente una lista de blogs (sin envoltorio)
        if (json is List) {
          allLoadedBlogs = List<Blog>.from(json.map((x) => Blog.fromJson(x)));
        }
        // Si el servidor envuelve los blogs en un objeto con campo 'blogs'
        else if (json is Map<String, dynamic> && json.containsKey('blogs')) {
          allLoadedBlogs =
              List<Blog>.from(json['blogs'].map((x) => Blog.fromJson(x)));
        }

        // Creamos una lista local para evitar problemas de estado
        final publishedBlogs = 
            allLoadedBlogs.where((blog) => blog.publicado == true).toList();
            
        // Actualizamos el estado interno solo si no causará problemas
        try {
          _allBlogs = publishedBlogs;
        } catch (e) {
          print('Error al actualizar estado interno: $e');
          // No hacemos nada si hay error al actualizar el estado
        }

        // Devolvemos directamente la lista filtrada
        return publishedBlogs;
      } else {
        throw Exception('Respuesta vacía del servidor');
      }
    } catch (e) {
      print('Error al cargar blogs publicados (SN): $e');
      return [];
    }
  }

  // Limpiar modal/formulario
  void cleanBlogModal() {
    _blogModal = blogDummy;
    _tituloEsBlogModal = '';
    _tituloEnBlogModal = '';
    _contenidoEsBlogModal = '';
    _contenidoEnBlogModal = '';
    _imagenBlogModal = '';
    _publicadoBlogModal = true;
    _fechaPublicacionBlogModal = DateTime.now();
    // notifyListeners();
  }

  // Validar formulario
  bool isValidForm() {
    if (_tituloEsBlogModal.isEmpty || _tituloEnBlogModal.isEmpty) {
      NotifServ.showSnackbarError(
          'Los títulos en ambos idiomas son requeridos', Colors.red);
      return false;
    }
    if (_contenidoEsBlogModal.isEmpty || _contenidoEnBlogModal.isEmpty) {
      NotifServ.showSnackbarError(
          'El contenido en ambos idiomas es requerido', Colors.red);
      return false;
    }
    return true;
  }

  // Obtener blogs disponibles para relacionar con el blog actual
  Future<List<Blog>> getBlogsDisponiblesParaRelacionar(String blogId) async {
    try {
      isLoading = true;
      // notifyListeners();

      print('Obteniendo blogs disponibles para relacionar con blogId: $blogId');
      final json = await JpApi.httpGet('/blogs/disponibles/$blogId');

      if (json != null) {
        List<Blog> disponibles = [];

        // Si el servidor devuelve directamente una lista de blogs
        if (json is List) {
          disponibles = List<Blog>.from(json.map((x) => Blog.fromJson(x)));
        }
        // Si el servidor envuelve los blogs en un objeto
        else if (json is Map<String, dynamic> &&
            json.containsKey('disponibles')) {
          disponibles =
              List<Blog>.from(json['disponibles'].map((x) => Blog.fromJson(x)));
        }

        _blogsDisponiblesParaRelacionar = disponibles;
        // notifyListeners();

        isLoading = false;
        // notifyListeners();
        return disponibles;
      } else {
        isLoading = false;
        // notifyListeners();
        throw Exception('Respuesta vacía del servidor');
      }
    } catch (e) {
      isLoading = false;
      // notifyListeners();
      print('Error al obtener blogs disponibles: $e');
      NotifServ.showSnackbarError(
          'Error al obtener blogs disponibles: $e', Colors.red);
      return [];
    }
  }
  
  // Versión silenciosa para usar durante la construcción de widgets
  Future<List<Blog>> getBlogsDisponiblesParaRelacionarSN(String blogId) async {
    try {
      // No notificamos cambios de estado para evitar errores durante la construcción
      print('Obteniendo blogs disponibles (SN) para relacionar con blogId: $blogId');
      final json = await JpApi.httpGet('/blogs/disponibles/$blogId');

      if (json != null) {
        List<Blog> disponibles = [];

        // Si el servidor devuelve directamente una lista de blogs
        if (json is List) {
          disponibles = List<Blog>.from(json.map((x) => Blog.fromJson(x)));
        }
        // Si el servidor envuelve los blogs en un objeto con clave "blogs" (formato actual del servidor)
        else if (json is Map<String, dynamic> &&
            json.containsKey('blogs')) {
          print('Encontrada respuesta con formato {blogs: [...]}');
          disponibles =
              List<Blog>.from(json['blogs'].map((x) => Blog.fromJson(x)));
        }
        // Mantener compatibilidad con formato anterior usando clave "disponibles"
        else if (json is Map<String, dynamic> &&
            json.containsKey('disponibles')) {
          disponibles =
              List<Blog>.from(json['disponibles'].map((x) => Blog.fromJson(x)));
        }

        // Actualizamos el valor sin notificar
        _blogsDisponiblesParaRelacionar = disponibles;
        return disponibles;
      } else {
        throw Exception('Respuesta vacía del servidor');
      }
    } catch (e) {
      print('Error al obtener blogs disponibles (SN): $e');
      return [];
    }
  }

  // Caché para blogs relacionados para evitar múltiples llamadas API
  final Map<String, List<Blog>> _relacionadosCache = {};

  // Obtener artículos relacionados de un blog específico
  Future<List<Blog>> getBlogsRelacionados(String blogId) async {
    // Evitar operaciones innecesarias para IDs vacíos
    if (blogId.isEmpty) {
      print('No se puede obtener blogs relacionados: blogId está vacío');
      return [];
    }

    // Verificar si ya tenemos estos blogs en caché
    if (_relacionadosCache.containsKey(blogId)) {
      print('Usando blogs relacionados en caché para blogId: $blogId');
      // Devolver una copia para evitar modificaciones accidentales
      return List<Blog>.from(_relacionadosCache[blogId] ?? []);
    }

    try {
      print('Obteniendo blogs relacionados para blogId: $blogId');

      // Intentar obtener desde el endpoint correcto
      try {
        // Primera opción: intentar obtener de /blogs/{id}/relacionados
        final json = await JpApi.httpGet('/blogs/$blogId/relacionados');

        if (json != null) {
          try {
            List<Blog> relacionados = _procesarRespuestaRelacionados(json);
            if (relacionados.isNotEmpty) {
              print(
                  'Blogs relacionados obtenidos desde /blogs/$blogId/relacionados: ${relacionados.length}');
              _relacionadosCache[blogId] = relacionados;
              return relacionados;
            }
          } catch (processingError) {
            print(
                'Error al procesar respuesta de relacionados: $processingError');
          }
        }
      } catch (e) {
        print('Error al obtener de /blogs/$blogId/relacionados: $e');
        // Continuamos con el siguiente intento
      }

      try {
        // Segunda opción: intentar obtener el blog completo y extraer sus relacionados
        final blogJson = await JpApi.httpGet('/blogs/$blogId');

        if (blogJson != null) {
          // Verificar si es un objeto antes de intentar acceder a sus propiedades
          if (blogJson is Map<String, dynamic>) {
            // Extraer los relacionados del blog
            if (blogJson.containsKey('relacionados') &&
                blogJson['relacionados'] != null) {
              print('Blog contiene relacionados en su estructura');
              var relacionadosData = blogJson['relacionados'];

              if (relacionadosData is List) {
                try {
                  List<Blog> relacionados = List<Blog>.from(
                      relacionadosData.map((x) => Blog.fromJson(x)));
                  print(
                      'Blogs relacionados extraídos del blog: ${relacionados.length}');

                  // Actualizar los IDs relacionados para uso en formularios
                  _idsRelacionados =
                      relacionados.map((blog) => blog.id).toList();
                  // notifyListeners();

                  // Guardar en caché
                  _relacionadosCache[blogId] = relacionados;
                  return relacionados;
                } catch (parseError) {
                  print('Error al parsear blogs relacionados: $parseError');
                }
              }
            }
          } else {
            print(
                'La respuesta no es un objeto válido: ${blogJson.runtimeType}');
          }
        }
      } catch (e) {
        print('Error al obtener el blog completo: $e');
      } // Tercera opción: obtener blogs recientes como alternativa
      try {
        print('Obteniendo blogs recientes como alternativa');
        // Verificar si ya tenemos blogs recientes en caché
        if (_relacionadosCache.containsKey('recientes')) {
          print('Usando blogs recientes en caché');
          List<Blog> blogs = _relacionadosCache['recientes']!;
          // Filtrar el blog actual si está en la lista
          blogs = blogs.where((blog) => blog.id != blogId).toList();
          return blogs;
        }

        final json = await JpApi.httpGet('/blogs?limit=5&skip=0');

        if (json != null) {
          List<Blog> blogs = _procesarRespuestaRelacionados(json);

          // Guardar en caché para uso futuro
          _relacionadosCache['recientes'] = blogs;

          // Filtrar el blog actual si está en la lista
          blogs = blogs.where((blog) => blog.id != blogId).toList();

          if (blogs.isNotEmpty) {
            print(
                'Blogs recientes obtenidos como alternativa: ${blogs.length}');
            // Guardar en caché para este blog específico
            _relacionadosCache[blogId] = blogs;
            return blogs;
          }
        }
      } catch (e) {
        print('Error al obtener blogs recientes: $e');
      }

      // Si llegamos aquí, no pudimos obtener blogs relacionados
      print('No se pudieron obtener blogs relacionados');
      // Guardar lista vacía en caché para este blog para evitar llamadas repetidas
      _relacionadosCache[blogId] = [];
      return [];
    } catch (e) {
      print('Error general al obtener blogs relacionados: $e');
      // Guardar lista vacía en caché para este blog para evitar llamadas repetidas
      _relacionadosCache[blogId] = [];
      return [];
    }
  }
  
  // Versión silenciosa para usar durante la construcción de widgets
  Future<List<Blog>> getBlogsRelacionadosSN(String blogId) async {
    // Evitar operaciones innecesarias para IDs vacíos
    if (blogId.isEmpty) {
      print('No se puede obtener blogs relacionados (SN): blogId está vacío');
      return [];
    }

    // Verificar si ya tenemos estos blogs en caché
    if (_relacionadosCache.containsKey(blogId)) {
      print('Usando blogs relacionados en caché (SN) para blogId: $blogId');
      // Devolver una copia para evitar modificaciones accidentales
      return List<Blog>.from(_relacionadosCache[blogId] ?? []);
    }

    try {
      print('Obteniendo blogs relacionados (SN) para blogId: $blogId');

      // Intentar obtener desde el endpoint correcto
      try {
        // Primera opción: intentar obtener de /blogs/{id}/relacionados
        final json = await JpApi.httpGet('/blogs/$blogId/relacionados');

        if (json != null) {
          try {
            List<Blog> relacionados = _procesarRespuestaRelacionados(json);
            if (relacionados.isNotEmpty) {
              print(
                  'Blogs relacionados (SN) obtenidos desde /blogs/$blogId/relacionados: ${relacionados.length}');
              _relacionadosCache[blogId] = relacionados;
              return relacionados;
            }
          } catch (processingError) {
            print(
                'Error al procesar respuesta de relacionados (SN): $processingError');
          }
        }
      } catch (e) {
        print('Error al obtener de /blogs/$blogId/relacionados (SN): $e');
      }

      try {
        // Segunda opción: intentar obtener el blog completo y extraer sus relacionados
        final blogJson = await JpApi.httpGet('/blogs/$blogId');

        if (blogJson != null) {
          // Verificar si es un objeto antes de intentar acceder a sus propiedades
          if (blogJson is Map<String, dynamic>) {
            // Extraer los relacionados del blog
            if (blogJson.containsKey('relacionados') &&
                blogJson['relacionados'] != null) {
              print('Blog contiene relacionados en su estructura (SN)');
              var relacionadosData = blogJson['relacionados'];

              if (relacionadosData is List) {
                try {
                  List<Blog> relacionados = List<Blog>.from(
                      relacionadosData.map((x) => Blog.fromJson(x)));
                  print(
                      'Blogs relacionados extraídos del blog (SN): ${relacionados.length}');

                  // Actualizar los IDs relacionados para uso en formularios sin notificar
                  _idsRelacionados = relacionados.map((blog) => blog.id).toList();
                  
                  // Guardar en caché
                  _relacionadosCache[blogId] = relacionados;
                  return relacionados;
                } catch (parseError) {
                  print('Error al parsear blogs relacionados (SN): $parseError');
                }
              }
            }
          }
        }
      } catch (e) {
        print('Error al obtener el blog completo (SN): $e');
      }

      // Si llegamos aquí, intentamos recuperar blogs recientes como alternativa
      try {
        if (_relacionadosCache.containsKey('recientes')) {
          print('Usando blogs recientes en caché (SN)');
          List<Blog> blogs = _relacionadosCache['recientes']!;
          blogs = blogs.where((blog) => blog.id != blogId).toList();
          return blogs;
        }

        final json = await JpApi.httpGet('/blogs?limit=5&skip=0');

        if (json != null) {
          List<Blog> blogs = _procesarRespuestaRelacionados(json);
          _relacionadosCache['recientes'] = blogs;
          blogs = blogs.where((blog) => blog.id != blogId).toList();
          
          if (blogs.isNotEmpty) {
            print('Blogs recientes obtenidos como alternativa (SN): ${blogs.length}');
            _relacionadosCache[blogId] = blogs;
            return blogs;
          }
        }
      } catch (e) {
        print('Error al obtener blogs recientes (SN): $e');
      }

      // Si llegamos aquí, no pudimos obtener blogs relacionados
      print('No se pudieron obtener blogs relacionados (SN)');
      _relacionadosCache[blogId] = [];
      return [];
    } catch (e) {
      print('Error general al obtener blogs relacionados (SN): $e');
      _relacionadosCache[blogId] = [];
      return [];
    }
  }

  // Método auxiliar para procesar la respuesta de blogs relacionados
  List<Blog> _procesarRespuestaRelacionados(dynamic json) {
    List<Blog> relacionados = [];

    try {
      // Verificar que json no sea nulo
      if (json == null) {
        print('Respuesta nula recibida');
        return relacionados;
      }

      // Manejar diferentes formatos de respuesta
      if (json is List) {
        // Si el servidor devuelve directamente una lista de blogs
        print('Formato de respuesta: Lista directa de blogs');
        try {
          relacionados = List<Blog>.from(json.map((x) => Blog.fromJson(x)));
        } catch (e) {
          print('Error al procesar lista de blogs: $e');
        }
      } else if (json is Map<String, dynamic>) {
        try {
          // Si el servidor envuelve los blogs en un objeto
          if (json.containsKey('relacionados')) {
            print('Formato de respuesta: Objeto con propiedad "relacionados"');
            var relacionadosData = json['relacionados'];
            if (relacionadosData is List) {
              relacionados = List<Blog>.from(
                  relacionadosData.map((x) => Blog.fromJson(x)));
            }
          }
          // Si el servidor devuelve un objeto con propiedad "blogs"
          else if (json.containsKey('blogs')) {
            print('Formato de respuesta: Objeto con propiedad "blogs"');
            var blogsData = json['blogs'];
            if (blogsData is List) {
              relacionados =
                  List<Blog>.from(blogsData.map((x) => Blog.fromJson(x)));
            }
          }
          // Si el servidor devuelve un objeto con propiedad "data"
          else if (json.containsKey('data')) {
            print('Formato de respuesta: Objeto con propiedad "data"');
            var data = json['data'];
            if (data is List) {
              relacionados = List<Blog>.from(data.map((x) => Blog.fromJson(x)));
            } else if (data is Map<String, dynamic> &&
                data.containsKey('relacionados')) {
              var relacionadosData = data['relacionados'];
              if (relacionadosData is List) {
                relacionados = List<Blog>.from(
                    relacionadosData.map((x) => Blog.fromJson(x)));
              }
            }
          }
          // Si el servidor devuelve un objeto con otra estructura
          else {
            if (json.keys.isNotEmpty) {
              print(
                  'Formato de respuesta desconocido: ${json.keys.join(', ')}');
            } else {
              print('Objeto sin propiedades');
            }
          }
        } catch (mapError) {
          print('Error al procesar objeto: $mapError');
        }
      } else {
        print('Tipo de respuesta no manejado: ${json.runtimeType}');
      }

      // Filtrar blogs nulos o inválidos
      try {
        if (relacionados.isNotEmpty) {
          relacionados = relacionados
              .where((blog) =>
                  blog.id.isNotEmpty &&
                  (blog.tituloEs.isNotEmpty || blog.tituloEn.isNotEmpty))
              .toList();

          // Actualizar los IDs relacionados para uso en formularios
          if (relacionados.isNotEmpty) {
            _idsRelacionados = relacionados.map((blog) => blog.id).toList();
            // notifyListeners();
          }
        }
      } catch (filterError) {
        print('Error al filtrar blogs relacionados: $filterError');
        // Si hay algún error durante el filtrado, regresamos una lista vacía segura
        relacionados = [];
      }
    } catch (e) {
      print('Error general al procesar respuesta de blogs relacionados: $e');
      relacionados = [];
    }

    return relacionados;
  }

  // Actualizar los artículos relacionados de un blog
  Future<bool> actualizarBlogsRelacionados(
      String blogId, List<String> idsRelacionados) async {
    try {
      print('Actualizando blogs relacionados para blogId: $blogId');
      print('IDs a relacionar: $idsRelacionados');

      // Asegurarnos de que solo enviamos IDs válidos (no vacíos)
      final idsValidos = idsRelacionados.where((id) => id.isNotEmpty).toList();

      final data = {'relacionados': idsValidos};

      print('Enviando datos al servidor como JSON: $data');
      final json = await JpApi.putJson('/blogs/$blogId/relacionados', data);

      if (json != null) {
        bool exito = false;

        if (json is Map<String, dynamic>) {
          // Verificar múltiples formatos posibles de respuesta exitosa
          if ((json.containsKey('ok') && json['ok'] == true) ||
              (json.containsKey('success') && json['success'] == true) ||
              (json.containsKey('status') &&
                  (json['status'] == 'ok' || json['status'] == 'success'))) {
            exito = true;
          }
          // Si la respuesta incluye el objeto blog actualizado
          else if (json.containsKey('blog') || json.containsKey('data')) {
            exito = true;
          }
        }

        if (exito) {
          NotifServ.showSnackbarError(
              'Blogs relacionados actualizados correctamente', Colors.green);
          return true;
        } else {
          print('Respuesta no reconocida como éxito: $json');
          NotifServ.showSnackbarError(
              'No se pudo actualizar los blogs relacionados', Colors.orange);
          return false;
        }
      } else {
        throw Exception('Respuesta vacía del servidor');
      }
    } catch (e) {
      print('Error al actualizar blogs relacionados: $e');
      NotifServ.showSnackbarError(
          'Error al actualizar blogs relacionados: $e', Colors.red);
      return false;
    }
  }
}

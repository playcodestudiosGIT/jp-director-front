import 'dart:convert';

class Blog {
  final String id;
  final String tituloEs;
  final String tituloEn;
  final String contenidoEs;
  final String contenidoEn;
  final String imagen;
  final bool publicado;
  final DateTime fechaPublicacion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Blog> relacionados; // Blogs relacionados

  Blog({
    required this.id,
    required this.tituloEs,
    required this.tituloEn,
    required this.contenidoEs,
    required this.contenidoEn,
    required this.imagen,
    required this.publicado,
    required this.fechaPublicacion,
    required this.createdAt,
    required this.updatedAt,
    List<Blog>? relacionados,
  }) : this.relacionados = relacionados ?? [];

  // Getter para obtener título según idioma
  String getTitulo(String idioma) {
    return idioma == 'es' ? tituloEs : tituloEn;
  }

  // Getter para obtener contenido según idioma
  String getContenido(String idioma) {
    return idioma == 'es' ? contenidoEs : contenidoEn;
  }

  factory Blog.fromRawJson(String str) => Blog.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Blog.fromJson(Map<String, dynamic> json) {
    try {
      // Evitamos imprimir todo el objeto json para prevenir errores de codificación
      print('Procesando Blog.fromJson, ID: ${json["_id"]}');
      
      // Manejo seguro de ID: podría estar como _id o id
      String blogId = '';
      if (json.containsKey("_id")) {
        blogId = json["_id"]?.toString() ?? '';
      } else if (json.containsKey("id")) {
        blogId = json["id"]?.toString() ?? '';
      }
      
      // Convertir publicado a bool de manera segura
      bool parsedEstado = true; // Valor por defecto
      
      if (json.containsKey("publicado")) {
        var publicadoValue = json["publicado"];
        if (publicadoValue is bool) {
          parsedEstado = publicadoValue;
        } else if (publicadoValue is int) {
          parsedEstado = publicadoValue == 1;
        } else if (publicadoValue is String) {
          // Intentar convertir de string
          parsedEstado = publicadoValue.toLowerCase() == 'true' || publicadoValue == '1';
        }
      } 
      // Compatibilidad con versiones anteriores que usaban "estado"
      else if (json.containsKey("estado")) {
        var estadoValue = json["estado"];
        if (estadoValue is bool) {
          parsedEstado = estadoValue;
        } else if (estadoValue is int) {
          parsedEstado = estadoValue == 1;
        } else if (estadoValue is String) {
          // Intentar convertir de string
          parsedEstado = estadoValue.toLowerCase() == 'true' || estadoValue == '1';
        }
      }
      
      // Manejo seguro de fechas
      DateTime parsedFechaPublicacion = DateTime.now();
      DateTime parsedCreatedAt = DateTime.now();
      DateTime parsedUpdatedAt = DateTime.now();
      
      try {
        if (json["fechaPublicacion"] != null) {
          parsedFechaPublicacion = DateTime.parse(json["fechaPublicacion"]);
        }
      } catch (e) {
        print('Error al parsear fechaPublicacion: ${json["fechaPublicacion"]}');
      }
      
      try {
        if (json["createdAt"] != null) {
          parsedCreatedAt = DateTime.parse(json["createdAt"]);
        }
      } catch (e) {
        print('Error al parsear createdAt: ${json["createdAt"]}');
      }
      
      try {
        if (json["updatedAt"] != null) {
          parsedUpdatedAt = DateTime.parse(json["updatedAt"]);
        }
      } catch (e) {
        print('Error al parsear updatedAt: ${json["updatedAt"]}');
      }

      // Manejo seguro de textos que pueden tener caracteres especiales
      String safeGetString(Map<String, dynamic> map, String key) {
        try {
          if (map[key] == null) return '';
          // Convertir explícitamente a String y manejar posibles errores de codificación
          return map[key].toString();
        } catch (e) {
          print('Error al convertir $key a String: $e');
          return ''; // Devolvemos string vacío en caso de error
        }
      }
      
      // Procesar blogs relacionados si existen
      List<Blog> blogsRelacionados = [];
      if (json.containsKey("relacionados") && json["relacionados"] != null) {
        try {
          // Convertir la lista de blogs relacionados
          if (json["relacionados"] is List) {
            // Filtrar elementos nulos antes de procesar
            List filteredList = (json["relacionados"] as List)
                .where((item) => item != null)
                .toList();
            
            if (filteredList.isNotEmpty) {
              blogsRelacionados = List<Blog>.from(
                filteredList.map((blog) => Blog.fromJson(blog))
              );
              print('Blogs relacionados procesados: ${blogsRelacionados.length}');
            }
          }
        } catch (e) {
          print('Error al procesar blogs relacionados: $e');
          // Ya está inicializado como lista vacía
        }
      }
      
      return Blog(
        id: blogId,
        tituloEs: safeGetString(json, "tituloEs"),
        tituloEn: safeGetString(json, "tituloEn"),
        contenidoEs: safeGetString(json, "contenidoEs"),
        contenidoEn: safeGetString(json, "contenidoEn"),
        imagen: safeGetString(json, "imagen"),
        publicado: parsedEstado,
        fechaPublicacion: parsedFechaPublicacion,
        createdAt: parsedCreatedAt,
        updatedAt: parsedUpdatedAt,
        relacionados: blogsRelacionados,
      );
    } catch (e) {
      print('Error en Blog.fromJson: $e');
      return blogDummy; // Devolver un blog vacío en caso de error
    }
  }
  
  // Método para sanitizar texto con posibles problemas de codificación
  static String sanitizeText(String text) {
    if (text.isEmpty) return '';
    
    try {
      // Intenta limpiar caracteres problemáticos
      return text
          .replaceAll('\u{FFFD}', '') // Reemplazar caracteres de reemplazo UTF
          .trim();
    } catch (e) {
      print('Error al sanitizar texto: $e');
      return ''; // En caso de error, devolver string vacío
    }
  }



  Map<String, dynamic> toJson() => {
        "_id": id,
        "tituloEs": tituloEs,
        "tituloEn": tituloEn,
        "contenidoEs": contenidoEs,
        "contenidoEn": contenidoEn,
        "imagen": imagen,
        "publicado": publicado,
        "fechaPublicacion": fechaPublicacion.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "relacionados": relacionados.map((r) => r.toJson()).toList(),
      };

  // Método para crear un blog vacío (para formularios)
  static Blog empty() => Blog(
        id: '',
        tituloEs: '',
        tituloEn: '',
        contenidoEs: '',
        contenidoEn: '',
        imagen: '',
        publicado: true,
        fechaPublicacion: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  // Método para copiar con cambios
  Blog copyWith({
    String? id,
    String? tituloEs,
    String? tituloEn,
    String? contenidoEs,
    String? contenidoEn,
    String? imagen,
    bool? publicado,
    DateTime? fechaPublicacion,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Blog>? relacionados,
  }) {
    return Blog(
      id: id ?? this.id,
      tituloEs: tituloEs ?? this.tituloEs,
      tituloEn: tituloEn ?? this.tituloEn,
      contenidoEs: contenidoEs ?? this.contenidoEs,
      contenidoEn: contenidoEn ?? this.contenidoEn,
      imagen: imagen ?? this.imagen,
      publicado: publicado ?? this.publicado,
      fechaPublicacion: fechaPublicacion ?? this.fechaPublicacion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      relacionados: relacionados ?? this.relacionados,
    );
  }
}

// Blog dummy para inicializaciones
final blogDummy = Blog(
  id: '',
  tituloEs: '',
  tituloEn: '',
  contenidoEs: '',
  contenidoEn: '',
  imagen: '',
  publicado: true,
  fechaPublicacion: DateTime.now(),
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  relacionados: [],
);





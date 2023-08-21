import 'modulo.dart';

class Curso {
    final String id;
    final String nombre;
    final String descripcion;
    final bool estado;
    final bool publicado;
    final List<Modulo> modulos;
    final String img;
    final String urlImgCert;
    final String duracion;
    final String usuario;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String precio;
    final String baner;

    Curso({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.estado,
        required this.publicado,
        required this.modulos,
        required this.img,
        required this.urlImgCert,
        required this.duracion,
        required this.usuario,
        required this.createdAt,
        required this.updatedAt,
        required this.precio,
        required this.baner,
    });

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json["_id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        publicado: json["publicado"],
        modulos: List<Modulo>.from(json["modulos"].map((x) => Modulo.fromJson(x))),
        img: json["img"],
        urlImgCert: json["urlImgCert"],
        duracion: json["duracion"],
        usuario: json["usuario"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        precio: json["precio"],
        baner: json["baner"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "modulos": List<dynamic>.from(modulos.map((x) => x.toJson())),
        "img": img,
        "urlImgCert": urlImgCert,
        "duracion": duracion,
        "usuario": usuario,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "precio": precio,
        "baner": baner,
    };
}
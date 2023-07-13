import 'dart:convert';

import 'coments.dart';

class Modulo {
    String id;
    String nombre;
    bool estado;
    List<Coment> coments;
    String usuario;
    String curso;
    String descripcion;
    String img;
    String video;
    String descarga;
    DateTime createdAt;
    DateTime updatedAt;

    Modulo({
        required this.estado,
        required this.coments,
        required this.descripcion,
        required this.img,
        required this.video,
        required this.descarga,
        required this.id,
        required this.nombre,
        required this.curso,
        required this.usuario,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Modulo.fromRawJson(String str) => Modulo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Modulo.fromJson(Map<String, dynamic> json) => Modulo(
        estado: json["estado"],
        coments: List<Coment>.from(json["coments"].map((x) => Coment.fromJson(x))),
        descripcion: json["descripcion"],
        img: json["img"],
        video: json["video"],
        descarga: json["descarga"],
        id: json["_id"],
        nombre: json["nombre"],
        curso: json["curso"],
        usuario: json["usuario"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "estado": estado,
        "coments": List<dynamic>.from(coments.map((x) => x.toJson())),
        "descripcion": descripcion,
        "img": img,
        "video": video,
        "descarga": descarga,
        "_id": id,
        "nombre": nombre,
        "curso": curso,
        "usuario": usuario,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
import 'dart:convert';

import 'modulo.dart';

class Curso {
    String subtitle;
    String descripcion;
    bool estado;
    List<Modulo> modulos;
    String img;
    String id;
    String usuario;
    String duracion;
    String nombre;
    DateTime createdAt;
    DateTime updatedAt;

    Curso({
        required this.subtitle,
        required this.descripcion,
        required this.estado,
        required this.modulos,
        required this.img,
        required this.id,
        required this.usuario,
        required this.duracion,
        required this.nombre,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Curso.fromRawJson(String str) => Curso.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        subtitle: json["subtitle"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        modulos: List<Modulo>.from(json["modulos"].map((x) => Modulo.fromJson(x))),
        img: json["img"],
        duracion: json["duracion"],
        id: json["_id"],
        usuario: json["usuario"],
        nombre: json["nombre"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "subtitle": subtitle,
        "descripcion": descripcion,
        "estado": estado,
        "modulos": List<dynamic>.from(modulos.map((x) => x.toJson())),
        "img": img,
        "duracion": duracion,
        "_id": id,
        "usuario": usuario,
        "nombre": nombre,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
import 'dart:convert';

import 'package:jp_director/models/modulo.dart';
import 'package:jp_director/models/testimonio.dart';

class Curso {
    final String id;
    final String nombre;
    final String precio;
    final String descripcion;
    final bool estado;
    final List<Modulo> modulos;
    final String img;
    final String urlImgCert;
    final String baner;
    final String duracion;
    final String usuario;
    final DateTime createdAt;
    final DateTime updatedAt;
    final bool publicado;
    final List<Testimonio> testimonios;
    final String totalEstudiantes;

    Curso({
        required this.id,
        required this.nombre,
        required this.precio,
        required this.descripcion,
        required this.estado,
        required this.modulos,
        required this.img,
        required this.urlImgCert,
        required this.baner,
        required this.duracion,
        required this.usuario,
        required this.createdAt,
        required this.updatedAt,
        required this.publicado,
        required this.testimonios,
        required this.totalEstudiantes,
    });

    factory Curso.fromRawJson(String str) => Curso.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json["_id"],
        nombre: json["nombre"],
        precio: json["precio"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        modulos: List<Modulo>.from(json["modulos"].map((x) => Modulo.fromJson(x))),
        img: json["img"],
        urlImgCert: json["urlImgCert"],
        baner: json["baner"],
        duracion: json["duracion"],
        usuario: json["usuario"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publicado: json["publicado"],
        testimonios: List<Testimonio>.from(json["testimonios"].map((x) => Testimonio.fromJson(x))),
        totalEstudiantes: json["totalEstudiantes"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "precio": precio,
        "descripcion": descripcion,
        "estado": estado,
        "modulos": List<dynamic>.from(modulos.map((x) => x.toJson())),
        "img": img,
        "urlImgCert": urlImgCert,
        "baner": baner,
        "duracion": duracion,
        "usuario": usuario,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publicado": publicado,
        "testimonios": List<dynamic>.from(testimonios.map((x) => x.toJson())),
        "totalEstudiantes": totalEstudiantes,
    };
}
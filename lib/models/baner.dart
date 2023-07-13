import 'dart:convert';

class Baner {
    String id;
    String nombre;
    String priceId;
    String cursoId;
    String img;
    DateTime createdAt;
    DateTime updatedAt;

    Baner({
        required this.id,
        required this.nombre,
        required this.priceId,
        required this.cursoId,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Baner.fromRawJson(String str) => Baner.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Baner.fromJson(Map<String, dynamic> json) => Baner(
        id: json["_id"],
        nombre: json["nombre"],
        priceId: json["priceId"],
        cursoId: json["cursoId"],
        img: json["img"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "priceId": priceId,
        "cursoId": cursoId,
        "img": img,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
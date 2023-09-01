import 'dart:convert';

class Testimonio {
    final String id;
    final String nombre;
    final String img;
    final String testimonio;
    final String cursoId;
    final bool estado;



    Testimonio({
        required this.id,
        required this.nombre,
        required this.img,
        required this.testimonio,
        required this.cursoId,
        required this.estado,

    });

    factory Testimonio.fromRawJson(String str) => Testimonio.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Testimonio.fromJson(Map<String, dynamic> json) => Testimonio(
        id: json["_id"],
        nombre: json["nombre"],
        img: json["img"],
        testimonio: json["testimonio"],
        cursoId: json["cursoId"],
        estado: json["estado"],

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "img": img,
        "testimonio": testimonio,
        "cursoId": cursoId,
        "estado": estado,

    };
}
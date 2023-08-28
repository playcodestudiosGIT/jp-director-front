import 'dart:convert';

import 'package:jp_director/models/resp.dart';

class Coment {
    bool estado;
    List<Resp> resp;
    String id;
    String usuario;
    String comentario;
    String curso;
    DateTime createdAt;
    DateTime updatedAt;

    Coment({
        required this.estado,
        required this.resp,
        required this.id,
        required this.usuario,
        required this.comentario,
        required this.curso,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Coment.fromRawJson(String str) => Coment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Coment.fromJson(Map<String, dynamic> json) => Coment(
        estado: json["estado"],
        resp: List<Resp>.from(json["resp"].map((x) => Resp.fromJson(x))),
        id: json["_id"],
        usuario: json["usuario"],
        comentario: json["comentario"],
        curso: json["curso"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "estado": estado,
        "resp": List<dynamic>.from(resp.map((x) => x.toJson())),
        "_id": id,
        "usuario": usuario,
        "comentario": comentario,
        "curso": curso,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
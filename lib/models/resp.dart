import 'dart:convert';

class Resp {
    bool estado;
    String id;
    String usuario;
    String respuesta;
    String coment;
    DateTime createdAt;
    DateTime updatedAt;

    Resp({
        required this.estado,
        required this.id,
        required this.usuario,
        required this.respuesta,
        required this.coment,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Resp.fromRawJson(String str) => Resp.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Resp.fromJson(Map<String, dynamic> json) => Resp(
        estado: json["estado"],
        id: json["_id"],
        usuario: json["usuario"],
        respuesta: json["respuesta"],
        coment: json["coment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "estado": estado,
        "_id": id,
        "usuario": usuario,
        "respuesta": respuesta,
        "coment": coment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
import 'dart:convert';

class Certificado {
    String id;
    String urlPdf;
    String cursoId;
    String usuarioId;
    DateTime createdAt;
    DateTime updatedAt;


    Certificado({
        required this.id,
        required this.urlPdf,
        required this.cursoId,
        required this.usuarioId,
        required this.createdAt,
        required this.updatedAt,

    });

    factory Certificado.fromRawJson(String str) => Certificado.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Certificado.fromJson(Map<String, dynamic> json) => Certificado(
        id: json["_id"],
        urlPdf: json["urlPdf"],
        cursoId: json["cursoId"],
        usuarioId: json["usuarioId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "urlPdf": urlPdf,
        "cursoId": cursoId,
        "usuarioId": usuarioId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),

    };
}
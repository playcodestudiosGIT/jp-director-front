// To parse this JSON data, do
//
//     final fromsResponse = fromsResponseFromJson(jsonString);

import 'dart:convert';

import '../formulario.dart';

class FromsResponse {
    int total;
    List<Formulario> formularios;

    FromsResponse({
        required this.total,
        required this.formularios,
    });

    factory FromsResponse.fromRawJson(String str) => FromsResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FromsResponse.fromJson(Map<String, dynamic> json) => FromsResponse(
        total: json["total"],
        formularios: List<Formulario>.from(json["formularios"].map((x) => Formulario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "formularios": List<dynamic>.from(formularios.map((x) => x.toJson())),
    };
}



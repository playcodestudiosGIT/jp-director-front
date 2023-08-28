// To parse this JSON data, do
//
//     final allRespuestasResponse = allRespuestasResponseFromJson(jsonString);

import 'dart:convert';

import 'package:jp_director/models/resp.dart';

class AllRespuestasResponse {
    int total;
    List<Resp> respuestas;

    AllRespuestasResponse({
        required this.total,
        required this.respuestas,
    });

    factory AllRespuestasResponse.fromRawJson(String str) => AllRespuestasResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllRespuestasResponse.fromJson(Map<String, dynamic> json) => AllRespuestasResponse(
        total: json["total"],
        respuestas: List<Resp>.from(json["respuestas"].map((x) => Resp.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "respuestas": List<dynamic>.from(respuestas.map((x) => x.toJson())),
    };
}



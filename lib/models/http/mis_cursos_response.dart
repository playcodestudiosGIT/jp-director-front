// To parse this JSON data, do
//
//     final misCursosResponse = misCursosResponseFromJson(jsonString);

import 'package:jp_director/models/curso.dart';
import 'dart:convert';

class MisCursosResponse {
    final List<Curso> cursos;

    MisCursosResponse({
        required this.cursos,
    });

    factory MisCursosResponse.fromRawJson(String str) => MisCursosResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MisCursosResponse.fromJson(Map<String, dynamic> json) => MisCursosResponse(
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
    };
}

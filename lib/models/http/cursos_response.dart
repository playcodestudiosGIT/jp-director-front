// To parse this JSON data, do
//
//     final cursosResponse = cursosResponseFromJson(jsonString);

import 'dart:convert';

import '../curso.dart';

CursosResponse cursosResponseFromJson(String str) => CursosResponse.fromJson(json.decode(str));

String cursosResponseToJson(CursosResponse data) => json.encode(data.toJson());

class CursosResponse {
    final int total;
    final List<Curso> cursos;

    CursosResponse({
        required this.total,
        required this.cursos,
    });

    factory CursosResponse.fromJson(Map<String, dynamic> json) => CursosResponse(
        total: json["total"],
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
    };
}




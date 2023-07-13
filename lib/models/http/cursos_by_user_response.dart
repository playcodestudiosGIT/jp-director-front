import 'dart:convert';

import '../curso.dart';

class CursosByUserResponse {
    int total;
    List<Curso> cursos;

    CursosByUserResponse({
        required this.total,
        required this.cursos,
    });

    factory CursosByUserResponse.fromRawJson(String str) => CursosByUserResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CursosByUserResponse.fromJson(Map<String, dynamic> json) => CursosByUserResponse(
        total: json["total"],
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
    };
}
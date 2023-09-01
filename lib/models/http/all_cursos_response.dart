
import 'dart:convert';

import '../curso.dart';

class AllCursosResponse {
    final int total;
    final List<Curso> cursos;

    AllCursosResponse({
        required this.total,
        required this.cursos,
    });

    factory AllCursosResponse.fromRawJson(String str) => AllCursosResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllCursosResponse.fromJson(Map<String, dynamic> json) => AllCursosResponse(
        total: json["total"],
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
    };
}
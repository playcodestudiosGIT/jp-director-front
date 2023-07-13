// To parse this JSON data, do
//
//     final allUsuariosResp = allUsuariosRespFromJson(jsonString);

import 'dart:convert';

import '../usuario_model.dart';

class AllUsuariosResp {
    int total;
    List<Usuario> usuarios;

    AllUsuariosResp({
        required this.total,
        required this.usuarios,
    });

    factory AllUsuariosResp.fromRawJson(String str) => AllUsuariosResp.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllUsuariosResp.fromJson(Map<String, dynamic> json) => AllUsuariosResp(
        total: json["total"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}
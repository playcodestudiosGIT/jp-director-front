import 'dart:convert';

import 'package:jp_director/models/certificado.dart';
import 'package:jp_director/models/progress.dart';

class Usuario {
    String nombre;
    String apellido;
    String correo;
    String img;
    String telf;
    String me;
    String instagram;
    String facebook;
    String tiktok;
    String rol;
    bool estado;
    bool google;
    String sessionId;
    List<String> cursos;
    List<Progress> progress;
    List<Certificado> certificados;
    String confirmCode;
    DateTime createdAt;
    DateTime updatedAt;
    String uid;

    Usuario({
        required this.nombre,
        required this.apellido,
        required this.correo,
        required this.img,
        required this.telf,
        required this.me,
        required this.instagram,
        required this.facebook,
        required this.tiktok,
        required this.rol,
        required this.estado,
        required this.google,
        required this.sessionId,
        required this.cursos,
        required this.progress,
        required this.certificados,
        required this.confirmCode,
        required this.createdAt,
        required this.updatedAt,
        required this.uid,
    });

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        img: json["img"],
        telf: json["telf"],
        me: json["me"],
        instagram: json["instagram"],
        facebook: json["facebook"],
        tiktok: json["tiktok"],
        rol: json["rol"],
        estado: json["estado"],
        google: json["google"],
        sessionId: json["sessionId"],
        cursos: List<String>.from(json["cursos"].map((x) => x)),
        progress: List<Progress>.from(json["progress"].map((x) => Progress.fromJson(x))),
        certificados: List<Certificado>.from(json["certificados"].map((x) => Certificado.fromJson(x))),
        confirmCode: json["confirmCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "img": img,
        "telf": telf,
        "me": me,
        "instagram": instagram,
        "facebook": facebook,
        "tiktok": tiktok,
        "rol": rol,
        "estado": estado,
        "google": google,
        "sessionId": sessionId,
        "cursos": List<dynamic>.from(cursos.map((x) => x)),
        "progress": List<dynamic>.from(progress.map((x) => x.toJson())),
        "certificados": List<dynamic>.from(certificados.map((x) => x.toJson())),
        "confirmCode": confirmCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}
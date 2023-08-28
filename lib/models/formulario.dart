import 'dart:convert';

class Formulario {
    String business;
    String operationyears;
    bool advertisingbefore;
    String facebookurl;
    String instagramurl;
    String tiktokurl;
    String advertisinglevel;
    bool onlineconference;
    String agree;
    String rootform;
    String email;
    String nombre;
    String phone;
    String uid;
    String createdAt;

    Formulario({
        required this.business,
        required this.operationyears,
        required this.advertisingbefore,
        required this.facebookurl,
        required this.tiktokurl,
        required this.instagramurl,
        required this.advertisinglevel,
        required this.onlineconference,
        required this.agree,
        required this.rootform,
        required this.email,
        required this.nombre,
        required this.phone,
        required this.uid,
        required this.createdAt,
    });

    factory Formulario.fromRawJson(String str) => Formulario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Formulario.fromJson(Map<String, dynamic> json) => Formulario(
        business: json["business"],
        operationyears: json["operationyears"],
        advertisingbefore: json["advertisingbefore"],
        facebookurl: json["facebookurl"],
        tiktokurl: json["tiktokurl"],
        instagramurl: json["instagramurl"],
        advertisinglevel: json["advertisinglevel"],
        onlineconference: json["onlineconference"],
        agree: json["agree"],
        rootform: json["rootform"],
        email: json["email"],
        nombre: json["nombre"],
        phone: json["phone"],
        uid: json["uid"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "business": business,
        "operationyears": operationyears,
        "advertisingbefore": advertisingbefore,
        "facebookurl": facebookurl,
        "tiktokurl": tiktokurl,
        "instagramurl": instagramurl,
        "advertisinglevel": advertisinglevel,
        "onlineconference": onlineconference,
        "agree": agree,
        "rootform": rootform,
        "email": email,
        "nombre": nombre,
        "phone": phone,
        "uid": uid,
        "createdAt": createdAt,
    };
}
import 'dart:convert';

class Lead {
    final String email;
    final String uid;
    final String telf;

    Lead({
        required this.email,
        required this.telf,
        required this.uid,
    });

    factory Lead.fromRawJson(String str) => Lead.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        email: json["email"],
        telf: json["telf"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "telf": telf,
        "uid": uid,
    };
}
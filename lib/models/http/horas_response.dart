// To parse this JSON data, do
//
//     final horasDisponiblesResponse = horasDisponiblesResponseFromMap(jsonString);

import 'dart:convert';

class HorasDisponiblesResponse {
    HorasDisponiblesResponse({
        required this.availablehours,
    });

    List<List<DateTime>> availablehours;

    factory HorasDisponiblesResponse.fromJson(String str) => HorasDisponiblesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HorasDisponiblesResponse.fromMap(Map<String, dynamic> json) => HorasDisponiblesResponse(
        availablehours: List<List<DateTime>>.from(json["availablehours"].map((x) => List<DateTime>.from(x.map((x) => DateTime.parse(x))))),
    );

    Map<String, dynamic> toMap() => {
        "availablehours": List<dynamic>.from(availablehours.map((x) => List<dynamic>.from(x.map((x) => x.toIso8601String())))),
    };
}

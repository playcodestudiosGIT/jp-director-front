// To parse this JSON data, do
//
//     final banersResponse = banersResponseFromJson(jsonString);

import 'dart:convert';

import '../baner.dart';

class BanersResponse {
    List<Baner> baners;
    int total;

    BanersResponse({
        required this.baners,
        required this.total,
    });

    factory BanersResponse.fromRawJson(String str) => BanersResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BanersResponse.fromJson(Map<String, dynamic> json) => BanersResponse(
        baners: List<Baner>.from(json["baners"].map((x) => Baner.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "baners": List<dynamic>.from(baners.map((x) => x.toJson())),
        "total": total,
    };
}
// To parse this JSON data, do
//
//     final leadsResponse = leadsResponseFromJson(jsonString);

import 'dart:convert';

import '../lead.dart';

class LeadsResponse {
    final List<Lead> leads;

    LeadsResponse({
        required this.leads,
    });

    factory LeadsResponse.fromRawJson(String str) => LeadsResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LeadsResponse.fromJson(Map<String, dynamic> json) => LeadsResponse(
        leads: List<Lead>.from(json["leads"].map((x) => Lead.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "leads": List<dynamic>.from(leads.map((x) => x.toJson())),
    };
}



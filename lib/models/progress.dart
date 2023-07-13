import 'dart:convert';

class Progress {
    String moduloId;
    int marker;
    bool isComplete;

    Progress({
        required this.moduloId,
        required this.marker,
        required this.isComplete,
    });

    factory Progress.fromRawJson(String str) => Progress.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        moduloId: json["moduloId"],
        marker: json["marker"],
        isComplete: json["isComplete"],
    );

    Map<String, dynamic> toJson() => {
        "moduloId": moduloId,
        "marker": marker,
        "isComplete": isComplete,
    };
}
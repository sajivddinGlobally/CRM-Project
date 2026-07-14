// To parse this JSON data, do
//
//     final markLostLeadResModel = markLostLeadResModelFromJson(jsonString);

import 'dart:convert';

MarkLostLeadResModel markLostLeadResModelFromJson(String str) => MarkLostLeadResModel.fromJson(json.decode(str));

String markLostLeadResModelToJson(MarkLostLeadResModel data) => json.encode(data.toJson());

class MarkLostLeadResModel {
    bool status;
    String message;

    MarkLostLeadResModel({
        required this.status,
        required this.message,
    });

    factory MarkLostLeadResModel.fromJson(Map<String, dynamic> json) => MarkLostLeadResModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}

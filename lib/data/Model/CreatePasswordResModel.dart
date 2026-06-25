// To parse this JSON data, do
//
//     final createPasswordResModel = createPasswordResModelFromJson(jsonString);

import 'dart:convert';

CreatePasswordResModel createPasswordResModelFromJson(String str) => CreatePasswordResModel.fromJson(json.decode(str));

String createPasswordResModelToJson(CreatePasswordResModel data) => json.encode(data.toJson());

class CreatePasswordResModel {
    bool? status;
    String? message;
    List<dynamic>? data;

    CreatePasswordResModel({
        this.status,
        this.message,
        this.data,
    });

    factory CreatePasswordResModel.fromJson(Map<String, dynamic> json) => CreatePasswordResModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}

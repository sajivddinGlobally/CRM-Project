// To parse this JSON data, do
//
//     final markDoneFollowUpModel = markDoneFollowUpModelFromJson(jsonString);

import 'dart:convert';

MarkDoneFollowUpModel markDoneFollowUpModelFromJson(String str) => MarkDoneFollowUpModel.fromJson(json.decode(str));

String markDoneFollowUpModelToJson(MarkDoneFollowUpModel data) => json.encode(data.toJson());

class MarkDoneFollowUpModel {
    bool? status;
    String? message;
    Data? data;

    MarkDoneFollowUpModel({
        this.status,
        this.message,
        this.data,
    });

    factory MarkDoneFollowUpModel.fromJson(Map<String, dynamic> json) => MarkDoneFollowUpModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? markDone;

    Data({
        this.id,
        this.markDone,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        markDone: json["mark_done"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mark_done": markDone,
    };
}

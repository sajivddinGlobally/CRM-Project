// To parse this JSON data, do
//
//     final deleteNotificationModel = deleteNotificationModelFromJson(jsonString);

import 'dart:convert';

DeleteNotificationModel deleteNotificationModelFromJson(String str) => DeleteNotificationModel.fromJson(json.decode(str));

String deleteNotificationModelToJson(DeleteNotificationModel data) => json.encode(data.toJson());

class DeleteNotificationModel {
    bool? status;
    String? message;

    DeleteNotificationModel({
        this.status,
        this.message,
    });

    factory DeleteNotificationModel.fromJson(Map<String, dynamic> json) => DeleteNotificationModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
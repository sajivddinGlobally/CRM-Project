// To parse this JSON data, do
//
//     final unreadCountModel = unreadCountModelFromJson(jsonString);

import 'dart:convert';

UnreadCountModel unreadCountModelFromJson(String str) => UnreadCountModel.fromJson(json.decode(str));

String unreadCountModelToJson(UnreadCountModel data) => json.encode(data.toJson());

class UnreadCountModel {
    bool? status;
    int? unreadCount;

    UnreadCountModel({
        this.status,
        this.unreadCount,
    });

    factory UnreadCountModel.fromJson(Map<String, dynamic> json) => UnreadCountModel(
        status: json["status"],
        unreadCount: json["unread_count"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "unread_count": unreadCount,
    };
}

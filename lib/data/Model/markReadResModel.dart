import 'dart:convert';

MarkReadResModel markReadResModelFromJson(String str) => MarkReadResModel.fromJson(json.decode(str));

String markReadResModelToJson(MarkReadResModel data) => json.encode(data.toJson());

class MarkReadResModel {
    bool? status;
    String? message;
    Data? data;

    MarkReadResModel({
        this.status,
        this.message,
        this.data,
    });

    factory MarkReadResModel.fromJson(Map<String, dynamic> json) => MarkReadResModel(
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
    bool? isRead;
    DateTime? readAt;

    Data({
        this.id,
        this.isRead,
        this.readAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        isRead: json["is_read"],
        readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "is_read": isRead,
        "read_at": readAt?.toIso8601String(),
    };
}
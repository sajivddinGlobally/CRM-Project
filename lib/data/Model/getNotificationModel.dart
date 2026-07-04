// To parse this JSON data, do
//
//     final getNotficationModel = getNotficationModelFromJson(jsonString);

import 'dart:convert';

GetNotficationModel getNotficationModelFromJson(String str) => GetNotficationModel.fromJson(json.decode(str));

String getNotficationModelToJson(GetNotficationModel data) => json.encode(data.toJson());

class GetNotficationModel {
    bool? status;
    String? message;
    List<Datum>? data;
    Meta? meta;

    GetNotficationModel({
        this.status,
        this.message,
        this.data,
        this.meta,
    });

    factory GetNotficationModel.fromJson(Map<String, dynamic> json) => GetNotficationModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class Datum {
    int? id;
    String? type;
    String? title;
    String? message;
    String? referenceType;
    int? referenceId;
    bool? isRead;
    DateTime? readAt;
    DateTime? createdAt;

    Datum({
        this.id,
        this.type,
        this.title,
        this.message,
        this.referenceType,
        this.referenceId,
        this.isRead,
        this.readAt,
        this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        message: json["message"],
        referenceType: json["reference_type"],
        referenceId: json["reference_id"],
        isRead: json["is_read"],
        readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "message": message,
        "reference_type": referenceType,
        "reference_id": referenceId,
        "is_read": isRead,
        "read_at": readAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
    };
}

class Meta {
    int? total;
    int? unreadCount;
    int? currentPage;
    int? lastPage;
    int? perPage;

    Meta({
        this.total,
        this.unreadCount,
        this.currentPage,
        this.lastPage,
        this.perPage,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        unreadCount: json["unread_count"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "unread_count": unreadCount,
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
    };
}

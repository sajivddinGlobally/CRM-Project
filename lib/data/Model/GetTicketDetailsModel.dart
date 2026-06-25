// To parse this JSON data, do
//
//     final getTicketDetailsModel = getTicketDetailsModelFromJson(jsonString);

import 'dart:convert';

GetTicketDetailsModel getTicketDetailsModelFromJson(String str) => GetTicketDetailsModel.fromJson(json.decode(str));

String getTicketDetailsModelToJson(GetTicketDetailsModel data) => json.encode(data.toJson());

class GetTicketDetailsModel {
    bool? status;
    String? message;
    Data? data;

    GetTicketDetailsModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetTicketDetailsModel.fromJson(Map<String, dynamic> json) => GetTicketDetailsModel(
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
    String? ticketId;
    String? issueTitle;
    String? issueDescription;
    String? issueCategory;
    String? priority;
    String? status;
    String? raisedBy;
    String? internalNote;
    String? attachment;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.ticketId,
        this.issueTitle,
        this.issueDescription,
        this.issueCategory,
        this.priority,
        this.status,
        this.raisedBy,
        this.internalNote,
        this.attachment,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        ticketId: json["ticket_id"],
        issueTitle: json["issue_title"],
        issueDescription: json["issue_description"],
        issueCategory: json["issue_category"],
        priority: json["priority"],
        status: json["status"],
        raisedBy: json["raised_by"],
        internalNote: json["internal_note"],
        attachment: json["attachment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_id": ticketId,
        "issue_title": issueTitle,
        "issue_description": issueDescription,
        "issue_category": issueCategory,
        "priority": priority,
        "status": status,
        "raised_by": raisedBy,
        "internal_note": internalNote,
        "attachment": attachment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

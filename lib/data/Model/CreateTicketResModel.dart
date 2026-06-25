// To parse this JSON data, do
//
//     final createTicketResModel = createTicketResModelFromJson(jsonString);

import 'dart:convert';

CreateTicketResModel createTicketResModelFromJson(String str) => CreateTicketResModel.fromJson(json.decode(str));

String createTicketResModelToJson(CreateTicketResModel data) => json.encode(data.toJson());

class CreateTicketResModel {
    bool? status;
    String? message;
    Data? data;

    CreateTicketResModel({
        this.status,
        this.message,
        this.data,
    });

    factory CreateTicketResModel.fromJson(Map<String, dynamic> json) => CreateTicketResModel(
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
    int? userId;
    String? ticketId;
    String? issueTitle;
    String? issueDescription;
    String? issueCategory;
    String? priority;
    String? status;
    String? raisedBy;
    String? attachment;
    String? internalNote;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.userId,
        this.ticketId,
        this.issueTitle,
        this.issueDescription,
        this.issueCategory,
        this.priority,
        this.status,
        this.raisedBy,
        this.attachment,
        this.internalNote,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        ticketId: json["ticket_id"],
        issueTitle: json["issue_title"],
        issueDescription: json["issue_description"],
        issueCategory: json["issue_category"],
        priority: json["priority"],
        status: json["status"],
        raisedBy: json["raised_by"],
        attachment: json["attachment"],
        internalNote: json["internal_note"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "ticket_id": ticketId,
        "issue_title": issueTitle,
        "issue_description": issueDescription,
        "issue_category": issueCategory,
        "priority": priority,
        "status": status,
        "raised_by": raisedBy,
        "attachment": attachment,
        "internal_note": internalNote,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

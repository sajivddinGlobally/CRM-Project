// To parse this JSON data, do
//
//     final createTicketBodyModel = createTicketBodyModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

CreateTicketBodyModel createTicketBodyModelFromJson(String str) => CreateTicketBodyModel.fromJson(json.decode(str));

String createTicketBodyModelToJson(CreateTicketBodyModel data) => json.encode(data.toJson());

class CreateTicketBodyModel {
    String? issueTitle;
    String? issueDescription;
    String? issueCategory;
    String? priority;
    File? attachment;
    String? internalNote;

    CreateTicketBodyModel({
        this.issueTitle,
        this.issueDescription,
        this.issueCategory,
        this.priority,
        this.attachment,
        this.internalNote,
    });

    factory CreateTicketBodyModel.fromJson(Map<String, dynamic> json) => CreateTicketBodyModel(
        issueTitle: json["issue_title"],
        issueDescription: json["issue_description"],
        issueCategory: json["issue_category"],
        priority: json["priority"],
        attachment: json["attachment"],
        internalNote: json["internal_note"],
    );

    Map<String, dynamic> toJson() => {
        "issue_title": issueTitle,
        "issue_description": issueDescription,
        "issue_category": issueCategory,
        "priority": priority,
        "attachment": attachment,
        "internal_note": internalNote,
    };
}

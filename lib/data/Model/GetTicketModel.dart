// To parse this JSON data, do
//
//     final getTicketModel = getTicketModelFromJson(jsonString);

import 'dart:convert';

GetTicketModel getTicketModelFromJson(String str) => GetTicketModel.fromJson(json.decode(str));

String getTicketModelToJson(GetTicketModel data) => json.encode(data.toJson());

class GetTicketModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetTicketModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetTicketModel.fromJson(Map<String, dynamic> json) => GetTicketModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? ticketId;
    IssueTitle? issueTitle;
    String? issueCategory;
    Priority? priority;
    String? status;
    String? raisedBy;
    String? attachment;
    DateTime? createdAt;

    Datum({
        this.id,
        this.ticketId,
        this.issueTitle,
        this.issueCategory,
        this.priority,
        this.status,
        this.raisedBy,
        this.attachment,
        this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        ticketId: json["ticket_id"],
        issueTitle: issueTitleValues.map[json["issue_title"]],
        issueCategory: json["issue_category"],
        priority: priorityValues.map[json["priority"]],
        status: json["status"],
        raisedBy: json["raised_by"],
        attachment: json["attachment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_id": ticketId,
        "issue_title": issueTitleValues.reverse[issueTitle],
        "issue_category": issueCategoryValues.reverse[issueCategory],
        "priority": priorityValues.reverse[priority],
        "status": statusValues.reverse[status],
        "raised_by": raisedByValues.reverse[raisedBy],
        "attachment": attachment,
        "created_at": createdAt?.toIso8601String(),
    };
}

enum IssueCategory {
    BILLING_ISSUE,
    CATEGORY,
    TECHNICAL_ISSUE
}

final issueCategoryValues = EnumValues({
    "billing_issue": IssueCategory.BILLING_ISSUE,
    "category": IssueCategory.CATEGORY,
    "technical_issue": IssueCategory.TECHNICAL_ISSUE
});

enum IssueTitle {
    CLI_0011,
    LOGIN_ISSUE,
    TITLE
}

final issueTitleValues = EnumValues({
    "CLI-0011": IssueTitle.CLI_0011,
    "Login Issue": IssueTitle.LOGIN_ISSUE,
    "title": IssueTitle.TITLE
});

enum Priority {
    HIGH,
    LOW,
    PRIORTY
}

final priorityValues = EnumValues({
    "high": Priority.HIGH,
    "low": Priority.LOW,
    "priorty": Priority.PRIORTY
});

enum RaisedBy {
    FIROZ_KHAN
}

final raisedByValues = EnumValues({
    "firoz khan": RaisedBy.FIROZ_KHAN
});

enum Status {
    OPEN
}

final statusValues = EnumValues({
    "Open": Status.OPEN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

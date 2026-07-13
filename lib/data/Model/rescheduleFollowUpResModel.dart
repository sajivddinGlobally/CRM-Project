// To parse this JSON data, do
//
//     final rescheduleFollowUpResModel = rescheduleFollowUpResModelFromJson(jsonString);

import 'dart:convert';

RescheduleFollowUpResModel rescheduleFollowUpResModelFromJson(String str) => RescheduleFollowUpResModel.fromJson(json.decode(str));

String rescheduleFollowUpResModelToJson(RescheduleFollowUpResModel data) => json.encode(data.toJson());

class RescheduleFollowUpResModel {
    bool? status;
    String? message;
    Data? data;

    RescheduleFollowUpResModel({
        this.status,
        this.message,
        this.data,
    });

    factory RescheduleFollowUpResModel.fromJson(Map<String, dynamic> json) => RescheduleFollowUpResModel(
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
    DateTime? reminderDate;
    String? reminderTime;
    String? reminderNote;

    Data({
        this.reminderDate,
        this.reminderTime,
        this.reminderNote,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        reminderDate: json["reminder_date"] == null ? null : DateTime.parse(json["reminder_date"]),
        reminderTime: json["reminder_time"],
        reminderNote: json["reminder_note"],
    );

    Map<String, dynamic> toJson() => {
        "reminder_date": reminderDate == null ? null : "${reminderDate!.year.toString().padLeft(4, '0')}-${reminderDate!.month.toString().padLeft(2, '0')}-${reminderDate!.day.toString().padLeft(2, '0')}",
        "reminder_time": reminderTime,
        "reminder_note": reminderNote,
    };
}

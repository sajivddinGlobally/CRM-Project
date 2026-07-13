// To parse this JSON data, do
//
//     final rescheduleFollowUpBodyModel = rescheduleFollowUpBodyModelFromJson(jsonString);

import 'dart:convert';

RescheduleFollowUpBodyModel rescheduleFollowUpBodyModelFromJson(String str) => RescheduleFollowUpBodyModel.fromJson(json.decode(str));

String rescheduleFollowUpBodyModelToJson(RescheduleFollowUpBodyModel data) => json.encode(data.toJson());

class RescheduleFollowUpBodyModel {
    String? reminderDate;
    String? reminderTime;
    String? reminderNote;

    RescheduleFollowUpBodyModel({
        this.reminderDate,
        this.reminderTime,
        this.reminderNote,
    });

    factory RescheduleFollowUpBodyModel.fromJson(Map<String, dynamic> json) => RescheduleFollowUpBodyModel(
        // reminderDate: json["reminder_date"] == null ? null : DateTime.parse(json["reminder_date"]),
       
       reminderDate: json['reminder_date'],
        reminderTime: json["reminder_time"],
        reminderNote: json["reminder_note"],
    );

    Map<String, dynamic> toJson() => {
        // "reminder_date": reminderDate == null ? null : "${reminderDate!.year.toString().padLeft(4, '0')}-${reminderDate!.month.toString().padLeft(2, '0')}-${reminderDate!.day.toString().padLeft(2, '0')}",
       
        "reminder_date":reminderDate,
        "reminder_time": reminderTime,
        "reminder_note": reminderNote,
    };
}

// To parse this JSON data, do
//
//     final addLeadBodyModel = addLeadBodyModelFromJson(jsonString);

import 'dart:convert';

AddLeadBodyModel addLeadBodyModelFromJson(String str) => AddLeadBodyModel.fromJson(json.decode(str));

String addLeadBodyModelToJson(AddLeadBodyModel data) => json.encode(data.toJson());

class AddLeadBodyModel {
    String? leadName;
    String? mobileNumber;
    String? alternateContact;
    String? email;
    String? businessName;
    String? industryType;
    String? city;
    String? budgetRange;
    String? leadSource;
    String? priority;
    String? reminderDate;
    String? reminderNote;
    String? reminderTime;

    AddLeadBodyModel({
        this.leadName,
        this.mobileNumber,
        this.alternateContact,
        this.email,
        this.businessName,
        this.industryType,
        this.city,
        this.budgetRange,
        this.leadSource,
        this.priority,
        this.reminderDate,
        this.reminderNote,
        this.reminderTime,
    });

    factory AddLeadBodyModel.fromJson(Map<String, dynamic> json) => AddLeadBodyModel(
        leadName: json["lead_name"],
        mobileNumber: json["mobile_number"],
        alternateContact: json["alternate_contact"],
        email: json["email"],
        businessName: json["business_name"],
        industryType: json["industry_type"],
        city: json["city"],
        budgetRange: json["budget_range"],
        leadSource: json["lead_source"],
        priority: json["priority"],
        // reminderDate: json["date"] == null ? null : DateTime.parse(json["date"]),
        reminderDate: json['reminderDate'],
        reminderNote: json["reminder_note"],
        reminderTime: json["reminder_time"],
    );

    Map<String, dynamic> toJson() => {
        "lead_name": leadName,
        "mobile_number": mobileNumber,
        "alternate_contact": alternateContact,
        "email": email,
        "business_name": businessName,
        "industry_type": industryType,
        "city": city,
        "budget_range": budgetRange,
        "lead_source": leadSource,
        "priority": priority,
        "reminder_date": reminderDate,
        "reminder_note": reminderNote,
        "reminder_time": reminderTime,
    };
}

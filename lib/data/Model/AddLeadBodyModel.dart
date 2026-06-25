import 'dart:convert';

AddLeadBodyModel addLeadBodyModelFromJson(String str) =>
    AddLeadBodyModel.fromJson(json.decode(str));

String addLeadBodyModelToJson(AddLeadBodyModel data) =>
    json.encode(data.toJson());

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
  DateTime? reminderDate;
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

  factory AddLeadBodyModel.fromJson(Map<String, dynamic> json) =>
      AddLeadBodyModel(
        leadName: json["lead_name"]?.toString(),
        mobileNumber: json["mobile_number"]?.toString(),
        alternateContact: json["alternate_contact"]?.toString(),
        email: json["email"]?.toString(),
        businessName: json["business_name"]?.toString(),
        industryType: json["industry_type"]?.toString(),
        city: json["city"]?.toString(),
        budgetRange: json["budget_range"]?.toString(),
        leadSource: json["lead_source"]?.toString(),
        priority: json["priority"]?.toString(),
        reminderDate: json["reminder_date"] == null
            ? null
            : DateTime.parse(json["reminder_date"]),
        reminderNote: json["reminder_note"]?.toString(),
        reminderTime: json["reminder_time"]?.toString(),
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
        "reminder_date": reminderDate?.toIso8601String(),
        "reminder_note": reminderNote,
        "reminder_time": reminderTime,
      };
}
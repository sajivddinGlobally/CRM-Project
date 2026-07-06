// To parse this JSON data, do
//
//     final leadUpdateBodyModel = leadUpdateBodyModelFromJson(jsonString);

import 'dart:convert';

LeadUpdateBodyModel leadUpdateBodyModelFromJson(String str) =>
    LeadUpdateBodyModel.fromJson(json.decode(str));

String leadUpdateBodyModelToJson(LeadUpdateBodyModel data) =>
    json.encode(data.toJson());

class LeadUpdateBodyModel {
  String? leadName;
  String? mobileNumber;
  String? alternateContact;
  String? email;
  String? address;
  String? businessName;
  String? industryType;
  String? city;
  int? interestedProductId;
  String? budgetRange;
  String? leadSource;
  String? priority;
  String? preferredTime;
  int? issetFollow;
  String? reminderDate;
  String? reminderNote;
  String? reminderTime;

  LeadUpdateBodyModel({
    this.leadName,
    this.mobileNumber,
    this.alternateContact,
    this.email,
    this.address,
    this.businessName,
    this.industryType,
    this.city,
    this.interestedProductId,
    this.budgetRange,
    this.leadSource,
    this.priority,
    this.preferredTime,
    this.issetFollow,
    this.reminderDate,
    this.reminderNote,
    this.reminderTime,
  });

  factory LeadUpdateBodyModel.fromJson(Map<String, dynamic> json) =>
      LeadUpdateBodyModel(
        leadName: json["lead_name"],
        mobileNumber: json["mobile_number"],
        alternateContact: json["alternate_contact"],
        email: json["email"],
        address: json["address"],
        businessName: json["business_name"],
        industryType: json["industry_type"],
        city: json["city"],
        interestedProductId: json["interested_product_id"],
        budgetRange: json["budget_range"],
        leadSource: json["lead_source"],
        issetFollow: json['is_setFollow'],
        priority: json["priority"],
        preferredTime: json["preferred_time"],
        reminderDate: json["reminder_date"],
        reminderTime: json["reminder_time"],
        reminderNote: json["reminder_note"],
      );

  Map<String, dynamic> toJson() => {
    "lead_name": leadName,
    "mobile_number": mobileNumber,
    "alternate_contact": alternateContact,
    "email": email,
    "address": address,
    "business_name": businessName,
    "industry_type": industryType,
    "city": city,
    "interested_product_id": interestedProductId,
    "budget_range": budgetRange,
    "lead_source": leadSource,
    "priority": priority,
    "preferred_time": preferredTime,
    "reminder_date": reminderDate,
    "reminder_time": reminderTime,
    "reminder_note": reminderNote,
    "is_setFollow": issetFollow,
  };
}

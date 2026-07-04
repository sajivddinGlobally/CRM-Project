// To parse this JSON data, do
//
//     final addLeadResModel = addLeadResModelFromJson(jsonString);

import 'dart:convert';

AddLeadResModel addLeadResModelFromJson(String str) =>
    AddLeadResModel.fromJson(json.decode(str));

String addLeadResModelToJson(AddLeadResModel data) =>
    json.encode(data.toJson());

class AddLeadResModel {
  bool? status;
  String? message;
  Data? data;

  AddLeadResModel({this.status, this.message, this.data});

  factory AddLeadResModel.fromJson(Map<String, dynamic> json) =>
      AddLeadResModel(
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
  String? assignedTo;
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
  String? status;
  String? createdByType;
  int? createdById;
  String? reminderDate;
  String? reminderTime;
  dynamic reminderNote;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.assignedTo,
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
    this.status,
    this.createdByType,
    this.createdById,
    this.reminderDate,
    this.reminderTime,
    this.reminderNote,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    assignedTo: json["assigned_to"],
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
    priority: json["priority"],
    preferredTime: json["preferred_time"],
    status: json["status"],
    createdByType: json["created_by_type"],
    createdById: json["created_by_id"],
    // reminderDate: json["reminder_date"] == null
    //     ? null
    //     : DateTime.parse(json["remindera_date"]),
    reminderDate: json['reminderData'],
    reminderTime: json["reminder_time"],
    reminderNote: json["reminder_note"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    id: json["id"],
  );
  get token => null;
  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "assigned_to": assignedTo,
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
    "status": status,
    "created_by_type": createdByType,
    "created_by_id": createdById,
    // "reminder_date": reminderDate?.toIso8601String(),
    "reminder_date":reminderDate,
    "reminder_time": reminderTime,
    "reminder_note": reminderNote,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}

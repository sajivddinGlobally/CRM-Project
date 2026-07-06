// To parse this JSON data, do
//
//     final leadUpdateResModel = leadUpdateResModelFromJson(jsonString);

import 'dart:convert';

LeadUpdateResModel leadUpdateResModelFromJson(String str) => LeadUpdateResModel.fromJson(json.decode(str));

String leadUpdateResModelToJson(LeadUpdateResModel data) => json.encode(data.toJson());

class LeadUpdateResModel {
    bool? status;
    String? message;
    Data? data;

    LeadUpdateResModel({
        this.status,
        this.message,
        this.data,
    });

    factory LeadUpdateResModel.fromJson(Map<String, dynamic> json) => LeadUpdateResModel(
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
    dynamic reminderDate;
    dynamic reminderTime;
    dynamic reminderNote;
    String? createdByType;
    int? createdById;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
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
        this.reminderDate,
        this.reminderTime,
        this.reminderNote,
        this.createdByType,
        this.createdById,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
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
        reminderDate: json["reminder_date"],
        reminderTime: json["reminder_time"],
        reminderNote: json["reminder_note"],
        createdByType: json["created_by_type"],
        createdById: json["created_by_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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
        "reminder_date": reminderDate,
        "reminder_time": reminderTime,
        "reminder_note": reminderNote,
        "created_by_type": createdByType,
        "created_by_id": createdById,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

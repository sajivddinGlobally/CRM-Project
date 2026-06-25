// To parse this JSON data, do
//
//     final getClientModel = getClientModelFromJson(jsonString);

import 'dart:convert';

GetClientModel getClientModelFromJson(String str) => GetClientModel.fromJson(json.decode(str));

String getClientModelToJson(GetClientModel data) => json.encode(data.toJson());

class GetClientModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetClientModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetClientModel.fromJson(Map<String, dynamic> json) => GetClientModel(
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
    String? clientId;
    String? clientName;
    dynamic category;
    String? industry;
    dynamic website;
    dynamic contactPerson;
    dynamic designation;
    String? primaryPhone;
    String? alternatePhone;
    String? email;
    String? businessName;
    dynamic industryType;
    String? plan;
    DateTime? planStartDate;
    String? planDuration;
    String? document;
    dynamic address;
    dynamic country;
    dynamic state;
    String? city;
    dynamic pincode;
    dynamic gstNumber;
    dynamic panNumber;
    dynamic gstType;
    String? assignedTo;
    String? createdByType;
    dynamic creditLimit;
    dynamic paymentTerms;
    dynamic paymentMode;
    dynamic autoPaymentReminder;
    dynamic reminderSchedule;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.clientId,
        this.clientName,
        this.category,
        this.industry,
        this.website,
        this.contactPerson,
        this.designation,
        this.primaryPhone,
        this.alternatePhone,
        this.email,
        this.businessName,
        this.industryType,
        this.plan,
        this.planStartDate,
        this.planDuration,
        this.document,
        this.address,
        this.country,
        this.state,
        this.city,
        this.pincode,
        this.gstNumber,
        this.panNumber,
        this.gstType,
        this.assignedTo,
        this.createdByType,
        this.creditLimit,
        this.paymentTerms,
        this.paymentMode,
        this.autoPaymentReminder,
        this.reminderSchedule,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        clientId: json["client_id"],
        clientName: json["client_name"],
        category: json["category"],
        industry: json["industry"],
        website: json["website"],
        contactPerson: json["contact_person"],
        designation: json["designation"],
        primaryPhone: json["primary_phone"],
        alternatePhone: json["alternate_phone"],
        email: json["email"],
        businessName: json["business_name"],
        industryType: json["industry_type"],
        plan: json["plan"],
        planStartDate: json["plan_start_date"] == null ? null : DateTime.parse(json["plan_start_date"]),
        planDuration: json["plan_duration"],
        document: json["document"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        gstNumber: json["gst_number"],
        panNumber: json["pan_number"],
        gstType: json["gst_type"],
        assignedTo: json["assigned_to"],
        createdByType: json["created_by_type"],
        creditLimit: json["credit_limit"],
        paymentTerms: json["payment_terms"],
        paymentMode: json["payment_mode"],
        autoPaymentReminder: json["auto_payment_reminder"],
        reminderSchedule: json["reminder_schedule"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "client_name": clientName,
        "category": category,
        "industry": industry,
        "website": website,
        "contact_person": contactPerson,
        "designation": designation,
        "primary_phone": primaryPhone,
        "alternate_phone": alternatePhone,
        "email": email,
        "business_name": businessName,
        "industry_type": industryType,
        "plan": plan,
        "plan_start_date": "${planStartDate!.year.toString().padLeft(4, '0')}-${planStartDate!.month.toString().padLeft(2, '0')}-${planStartDate!.day.toString().padLeft(2, '0')}",
        "plan_duration": planDuration,
        "document": document,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "pincode": pincode,
        "gst_number": gstNumber,
        "pan_number": panNumber,
        "gst_type": gstType,
        "assigned_to": assignedTo,
        "created_by_type": createdByType,
        "credit_limit": creditLimit,
        "payment_terms": paymentTerms,
        "payment_mode": paymentMode,
        "auto_payment_reminder": autoPaymentReminder,
        "reminder_schedule": reminderSchedule,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

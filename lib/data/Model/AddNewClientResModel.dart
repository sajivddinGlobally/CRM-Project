// To parse this JSON data, do
//
//     final addNewClientResModel = addNewClientResModelFromJson(jsonString);

import 'dart:convert';

AddNewClientResModel addNewClientResModelFromJson(String str) => AddNewClientResModel.fromJson(json.decode(str));

String addNewClientResModelToJson(AddNewClientResModel data) => json.encode(data.toJson());

class AddNewClientResModel {
    bool? status;
    String? message;
    Data? data;

    AddNewClientResModel({
        this.status,
        this.message,
        this.data,
    });

    factory AddNewClientResModel.fromJson(Map<String, dynamic> json) => AddNewClientResModel(
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
    String? clientId;
    String? clientName;
    String? primaryPhone;
    String? alternatePhone;
    String? email;
    String? businessName;
    String? industry;
    String? city;
    String? plan;
    DateTime? planStartDate;
    String? planDuration;
    String? assignedTo;
    String? document;
    String? status;
    String? createdByType;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.clientId,
        this.clientName,
        this.primaryPhone,
        this.alternatePhone,
        this.email,
        this.businessName,
        this.industry,
        this.city,
        this.plan,
        this.planStartDate,
        this.planDuration,
        this.assignedTo,
        this.document,
        this.status,
        this.createdByType,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        clientId: json["client_id"],
        clientName: json["client_name"],
        primaryPhone: json["primary_phone"],
        alternatePhone: json["alternate_phone"],
        email: json["email"],
        businessName: json["business_name"],
        industry: json["industry"],
        city: json["city"],
        plan: json["plan"],
        planStartDate: json["plan_start_date"] == null ? null : DateTime.parse(json["plan_start_date"]),
        planDuration: json["plan_duration"],
        assignedTo: json["assigned_to"],
        document: json["document"],
        status: json["status"],
        createdByType: json["created_by_type"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

  get token => null;

    Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "client_name": clientName,
        "primary_phone": primaryPhone,
        "alternate_phone": alternatePhone,
        "email": email,
        "business_name": businessName,
        "industry": industry,
        "city": city,
        "plan": plan,
        "plan_start_date": "${planStartDate!.year.toString().padLeft(4, '0')}-${planStartDate!.month.toString().padLeft(2, '0')}-${planStartDate!.day.toString().padLeft(2, '0')}",
        "plan_duration": planDuration,
        "assigned_to": assignedTo,
        "document": document,
        "status": status,
        "created_by_type": createdByType,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

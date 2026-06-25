// To parse this JSON data, do
//
//     final addNewClientBodyModel = addNewClientBodyModelFromJson(jsonString);

import 'dart:convert';

AddNewClientBodyModel addNewClientBodyModelFromJson(String str) => AddNewClientBodyModel.fromJson(json.decode(str));

String addNewClientBodyModelToJson(AddNewClientBodyModel data) => json.encode(data.toJson());

class AddNewClientBodyModel {
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

    AddNewClientBodyModel({
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
    });

    factory AddNewClientBodyModel.fromJson(Map<String, dynamic> json) => AddNewClientBodyModel(
        clientName: json["clientName"],
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
    );

    Map<String, dynamic> toJson() => {
        "clientName": clientName,
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
    };
}

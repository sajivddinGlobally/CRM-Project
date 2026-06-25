// To parse this JSON data, do
//
//     final editProfileBodyModel = editProfileBodyModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

EditProfileBodyModel editProfileBodyModelFromJson(String str) => EditProfileBodyModel.fromJson(json.decode(str));

String editProfileBodyModelToJson(EditProfileBodyModel data) => json.encode(data.toJson());

class EditProfileBodyModel {
    String? fullName;
    String? phone;
    String? email;
    DateTime? date;
    String? gender;
    String? sale;
    String? department;
    String? employeeId;
    String? contact;
    File? offerLetter;

    EditProfileBodyModel({
        this.fullName,
        this.phone,
        this.email,
        this.date,
        this.gender,
        this.sale,
        this.department,
        this.employeeId,
        this.contact,
        this.offerLetter,
    });

    factory EditProfileBodyModel.fromJson(Map<String, dynamic> json) => EditProfileBodyModel(
        fullName: json["full_name"],
        phone: json["phone"],
        email: json["email"],
         date: json["date"] == null ? null : DateTime.parse(json["date"]),
        gender: json["gender"],
        sale: json["sale"],
        department: json["department"],
        employeeId: json["employee_id"],
        contact: json["contact"],
        offerLetter: json["offer_letter"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone": phone,
        "email": email,
        "date": date,
        "gender": gender,
        "sale": sale,
        "department": department,
        "employee_id": employeeId,
        "contact": contact,
        "offer_letter": offerLetter,
    };
}

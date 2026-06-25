// To parse this JSON data, do
//
//     final loginResModel = loginResModelFromJson(jsonString);

import 'dart:convert';

LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));

String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());

class LoginResModel {
    bool? status;
    String? message;
    Data? data;

    LoginResModel({
        this.status,
        this.message,
        this.data,
    });

    factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
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
    String? token;
    String? tokenType;
    String? employeeId;
    String? fullName;
    String? email;
    String? designation;
    String? department;

    Data({
        this.token,
        this.tokenType,
        this.employeeId,
        this.fullName,
        this.email,
        this.designation,
        this.department,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        tokenType: json["token_type"],
        employeeId: json["employee_id"],
        fullName: json["full_name"],
        email: json["email"],
        designation: json["designation"],
        department: json["department"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "employee_id": employeeId,
        "full_name": fullName,
        "email": email,
        "designation": designation,
        "department": department,
    };
}

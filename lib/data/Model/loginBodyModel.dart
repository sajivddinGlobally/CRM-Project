// To parse this JSON data, do
//
//     final loginBodyModel = loginBodyModelFromJson(jsonString);

import 'dart:convert';

LoginBodyModel loginBodyModelFromJson(String str) => LoginBodyModel.fromJson(json.decode(str));

String loginBodyModelToJson(LoginBodyModel data) => json.encode(data.toJson());

class LoginBodyModel {
    String? employeeId;
    String? password;

    LoginBodyModel({
        this.employeeId,
        this.password,
    });

    factory LoginBodyModel.fromJson(Map<String, dynamic> json) => LoginBodyModel(
        employeeId: json["employee_id"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "password": password,
    };
}

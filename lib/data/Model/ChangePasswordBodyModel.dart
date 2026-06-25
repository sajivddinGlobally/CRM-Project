// To parse this JSON data, do
//
//     final changePasswordBodyModel = changePasswordBodyModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordBodyModel changePasswordBodyModelFromJson(String str) => ChangePasswordBodyModel.fromJson(json.decode(str));

String changePasswordBodyModelToJson(ChangePasswordBodyModel data) => json.encode(data.toJson());

class ChangePasswordBodyModel {
    String? newPassword;
    String? confirmPassword;

    ChangePasswordBodyModel({
        this.newPassword,
        this.confirmPassword,
    });

    factory ChangePasswordBodyModel.fromJson(Map<String, dynamic> json) => ChangePasswordBodyModel(
        newPassword: json["new_password"],
        confirmPassword: json["confirm_password"],
    );

    Map<String, dynamic> toJson() => {
        "new_password": newPassword,
        "confirm_password": confirmPassword,
    };
}

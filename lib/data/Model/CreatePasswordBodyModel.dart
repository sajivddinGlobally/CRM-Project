// To parse this JSON data, do
//
//     final createPasswordBodyModel = createPasswordBodyModelFromJson(jsonString);

import 'dart:convert';

CreatePasswordBodyModel createPasswordBodyModelFromJson(String str) => CreatePasswordBodyModel.fromJson(json.decode(str));

String createPasswordBodyModelToJson(CreatePasswordBodyModel data) => json.encode(data.toJson());

class CreatePasswordBodyModel {
    String? email;
    String? newPassword;
    String? confirmNewPassword;

    CreatePasswordBodyModel({
        this.email,
        this.newPassword,
        this.confirmNewPassword,
    });

    factory CreatePasswordBodyModel.fromJson(Map<String, dynamic> json) => CreatePasswordBodyModel(
        email: json["email"],
        newPassword: json["new_password"],
        confirmNewPassword: json["confirm_new_password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "new_password": newPassword,
        "confirm_new_password": confirmNewPassword,
    };
}

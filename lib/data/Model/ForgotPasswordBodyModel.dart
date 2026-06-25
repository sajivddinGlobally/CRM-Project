// To parse this JSON data, do
//
//     final forgotPasswordBodyModel = forgotPasswordBodyModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordBodyModel forgotPasswordBodyModelFromJson(String str) => ForgotPasswordBodyModel.fromJson(json.decode(str));

String forgotPasswordBodyModelToJson(ForgotPasswordBodyModel data) => json.encode(data.toJson());

class ForgotPasswordBodyModel {
    String? email;

    ForgotPasswordBodyModel({
        this.email,
    });

    factory ForgotPasswordBodyModel.fromJson(Map<String, dynamic> json) => ForgotPasswordBodyModel(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}

// To parse this JSON data, do
//
//     final forgotPasswordResModel = forgotPasswordResModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResModel forgotPasswordResModelFromJson(String str) => ForgotPasswordResModel.fromJson(json.decode(str));

String forgotPasswordResModelToJson(ForgotPasswordResModel data) => json.encode(data.toJson());

class ForgotPasswordResModel {
    bool? status;
    String? message;
    Data? data;

    ForgotPasswordResModel({
        this.status,
        this.message,
        this.data,
    });

    factory ForgotPasswordResModel.fromJson(Map<String, dynamic> json) => ForgotPasswordResModel(
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
    String? otp;

    Data({
        this.otp,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
    };
}

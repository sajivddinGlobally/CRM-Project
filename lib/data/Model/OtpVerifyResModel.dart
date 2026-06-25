// To parse this JSON data, do
//
//     final otpVerifyResModel = otpVerifyResModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyResModel otpVerifyResModelFromJson(String str) => OtpVerifyResModel.fromJson(json.decode(str));

String otpVerifyResModelToJson(OtpVerifyResModel data) => json.encode(data.toJson());

class OtpVerifyResModel {
    bool? status;
    String? message;
    Data? data;

    OtpVerifyResModel({
        this.status,
        this.message,
        this.data,
    });

    factory OtpVerifyResModel.fromJson(Map<String, dynamic> json) => OtpVerifyResModel(
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
    String? email;

    Data({
        this.email,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}

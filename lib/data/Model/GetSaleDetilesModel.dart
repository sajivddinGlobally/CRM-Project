// To parse this JSON data, do
//
//     final getSaleDetilesModel = getSaleDetilesModelFromJson(jsonString);

import 'dart:convert';

GetSaleDetilesModel getSaleDetilesModelFromJson(String str) => GetSaleDetilesModel.fromJson(json.decode(str));

String getSaleDetilesModelToJson(GetSaleDetilesModel data) => json.encode(data.toJson());

class GetSaleDetilesModel {
    bool? status;
    String? message;
    Data? data;

    GetSaleDetilesModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetSaleDetilesModel.fromJson(Map<String, dynamic> json) => GetSaleDetilesModel(
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
    int? id;
    String? productName;
    String? quantity;
    String? paymentStatus;
    String? paymentMethod;
    String? note;
    String? image;
    int? isSetFollow;
    String? date;
    String? time;
    String? remeniderNote;
    String? fullName;
    DateTime? createdAt;

    Data({
        this.id,
        this.productName,
        this.quantity,
        this.paymentStatus,
        this.paymentMethod,
        this.note,
        this.image,
        this.isSetFollow,
        this.date,
        this.time,
        this.remeniderNote,
        this.fullName,
        this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        note: json["note"],
        image: json["image"],
        isSetFollow: json["is_setFollow"],
        // date: json["date"] == null ? null : DateTime.parse(json["date"]),
        date: json['data'],
        time: json["time"],
        remeniderNote: json["remenider_note"],
        fullName: json["full_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "quantity": quantity,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "note": note,
        "image": image,
        "is_setFollow": isSetFollow,
        // "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "data":date,
        "time": time,
        "remenider_note": remeniderNote,
        "full_name": fullName,
        "created_at": createdAt?.toIso8601String(),
    };
}

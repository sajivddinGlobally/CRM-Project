// To parse this JSON data, do
//
//     final addSaleResModel = addSaleResModelFromJson(jsonString);

import 'dart:convert';

AddSaleResModel addSaleResModelFromJson(String str) => AddSaleResModel.fromJson(json.decode(str));

String addSaleResModelToJson(AddSaleResModel data) => json.encode(data.toJson());

class AddSaleResModel {
    bool? status;
    String? message;
    Data? data;

    AddSaleResModel({
        this.status,
        this.message,
        this.data,
    });

    factory AddSaleResModel.fromJson(Map<String, dynamic> json) => AddSaleResModel(
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
    int? employeeId;
    String? productName;
    String? quantity;
    String? paymentStatus;
    String? paymentMethod;
    String? note;
    String? image;
    dynamic isSetFollow;
    DateTime? date;
    String? time;
    String? remeniderNote;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.employeeId,
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
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
       employeeId: int.tryParse(json["employee_id"].toString()),
        productName: json["product_name"],
        quantity: json["quantity"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        note: json["note"],
        image: json["image"],
        isSetFollow: json["is_setFollow"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        remeniderNote: json["remenider_note"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "product_name": productName,
        "quantity": quantity,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "note": note,
        "image": image,
        "is_setFollow": isSetFollow,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "remenider_note": remeniderNote,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

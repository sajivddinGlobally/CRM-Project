// To parse this JSON data, do
//
//     final getSaleModel = getSaleModelFromJson(jsonString);

import 'dart:convert';

GetSaleModel getSaleModelFromJson(String str) => GetSaleModel.fromJson(json.decode(str));

String getSaleModelToJson(GetSaleModel data) => json.encode(data.toJson());

class GetSaleModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetSaleModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetSaleModel.fromJson(Map<String, dynamic> json) => GetSaleModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? productName;
    String? quantity;
    String? paymentStatus;
    String? paymentMethod;
    String? note;
    String? image;
    int? isSetFollow;
    DateTime? date;
    String? time;
    String? remeniderNote;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? employeeId;
    Employee? employee;

    Datum({
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
        this.createdAt,
        this.updatedAt,
        this.employeeId,
        this.employee,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        employeeId: json["employee_id"],
        employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
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
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "remenider_note": remeniderNote,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee_id": employeeId,
        "employee": employee?.toJson(),
    };
}

class Employee {
    int? id;
    String? fullName;

    Employee({
        this.id,
        this.fullName,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        fullName: json["full_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
    };
}

// To parse this JSON data, do
//
//     final addSaleBodyModel = addSaleBodyModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

AddSaleBodyModel addSaleBodyModelFromJson(String str) =>
    AddSaleBodyModel.fromJson(json.decode(str));

String addSaleBodyModelToJson(AddSaleBodyModel data) =>
    json.encode(data.toJson());

class AddSaleBodyModel {
  String? productName;
  String? quantity;
  String? paymentStatus;
  String? paymentMethod;
  String? note;
  DateTime? date;
  String? time;
  String? remeniderNote;
  File? image;

  AddSaleBodyModel({
    this.productName,
    this.quantity,
    this.paymentStatus,
    this.paymentMethod,
    this.note,
    this.image,
    this.date,
    this.time,
    this.remeniderNote,
  });

  factory AddSaleBodyModel.fromJson(Map<String, dynamic> json) =>
      AddSaleBodyModel(
        productName: json["product_name"],
        quantity: json["quantity"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        note: json["note"],
        image: json["image"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        remeniderNote: json["remenider_note"],
      );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "quantity": quantity,
    "payment_status": paymentStatus,
    "payment_method": paymentMethod,
    "note": note,
    "image": image,
    "date":
        "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "remenider_note": remeniderNote,
  };
}

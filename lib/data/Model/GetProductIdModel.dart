// To parse this JSON data, do
//
//     final productIdModel = productIdModelFromJson(jsonString);

import 'dart:convert';

ProductIdModel productIdModelFromJson(String str) => ProductIdModel.fromJson(json.decode(str));

String productIdModelToJson(ProductIdModel data) => json.encode(data.toJson());

class ProductIdModel {
    bool? status;
    String? message;
    List<Datum>? data;

    ProductIdModel({
        this.status,
        this.message,
        this.data,
    });

    factory ProductIdModel.fromJson(Map<String, dynamic> json) => ProductIdModel(
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
    String? sku;
    String? itemName;
    String? sellingPrice;
    int? quantity;
    int? threshold;

    Datum({
        this.id,
        this.sku,
        this.itemName,
        this.sellingPrice,
        this.quantity,
        this.threshold,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sku: json["sku"],
        itemName: json["item_name"],
        sellingPrice: json["selling_price"],
        quantity: json["quantity"],
        threshold: json["threshold"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "item_name": itemName,
        "selling_price": sellingPrice,
        "quantity": quantity,
        "threshold": threshold,
    };
}

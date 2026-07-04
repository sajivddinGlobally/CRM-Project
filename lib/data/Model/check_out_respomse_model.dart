// To parse this JSON data, do
//
//     final checkOutResponseModel = checkOutResponseModelFromJson(jsonString);

import 'dart:convert';

CheckOutResponseModel checkOutResponseModelFromJson(String str) => CheckOutResponseModel.fromJson(json.decode(str));

String checkOutResponseModelToJson(CheckOutResponseModel data) => json.encode(data.toJson());

class CheckOutResponseModel {
  bool? status;
  String? message;
  Data? data;

  CheckOutResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CheckOutResponseModel.fromJson(Map<String, dynamic> json) => CheckOutResponseModel(
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
  int? employeeId;
  DateTime? date;
  String? checkInTime;
  String? checkOutTime;
  String? checkInLatitude;
  String? checkInLongitude;
  double? checkOutLatitude;
  double? checkOutLongitude;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.employeeId,
    this.date,
    this.checkInTime,
    this.checkOutTime,
    this.checkInLatitude,
    this.checkInLongitude,
    this.checkOutLatitude,
    this.checkOutLongitude,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    employeeId: json["employee_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    checkInTime: json["check_in_time"],
    checkOutTime: json["check_out_time"],
    checkInLatitude: json["check_in_latitude"],
    checkInLongitude: json["check_in_longitude"],
    checkOutLatitude: json["check_out_latitude"]?.toDouble(),
    checkOutLongitude: json["check_out_longitude"]?.toDouble(),
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "check_in_time": checkInTime,
    "check_out_time": checkOutTime,
    "check_in_latitude": checkInLatitude,
    "check_in_longitude": checkInLongitude,
    "check_out_latitude": checkOutLatitude,
    "check_out_longitude": checkOutLongitude,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

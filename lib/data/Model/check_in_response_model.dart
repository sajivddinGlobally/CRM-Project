// To parse this JSON data, do
//
//     final checkInResponseModel = checkInResponseModelFromJson(jsonString);

import 'dart:convert';

CheckInResponseModel checkInResponseModelFromJson(String str) => CheckInResponseModel.fromJson(json.decode(str));

String checkInResponseModelToJson(CheckInResponseModel data) => json.encode(data.toJson());

class CheckInResponseModel {
  bool? status;
  String? message;
  Data? data;

  CheckInResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CheckInResponseModel.fromJson(Map<String, dynamic> json) => CheckInResponseModel(
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
  DateTime? date;
  String? checkInTime;
  double? checkInLatitude;
  double? checkInLongitude;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.employeeId,
    this.date,
    this.checkInTime,
    this.checkInLatitude,
    this.checkInLongitude,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    employeeId: json["employee_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    checkInTime: json["check_in_time"],
    checkInLatitude: json["check_in_latitude"]?.toDouble(),
    checkInLongitude: json["check_in_longitude"]?.toDouble(),
    status: json["status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "check_in_time": checkInTime,
    "check_in_latitude": checkInLatitude,
    "check_in_longitude": checkInLongitude,
    "status": status,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}

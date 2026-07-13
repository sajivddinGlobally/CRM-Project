// To parse this JSON data, do
//
//     final attendenceHistoryResponse = attendenceHistoryResponseFromJson(jsonString);

import 'dart:convert';


AttendenceHistoryResponse attendenceHistoryResponseFromJson(String str) => AttendenceHistoryResponse.fromJson(json.decode(str));

String attendenceHistoryResponseToJson(AttendenceHistoryResponse data) => json.encode(data.toJson());

class AttendenceHistoryResponse {
  bool? status;
  String? message;
  List<AttendanceLogData>? data;

  AttendenceHistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AttendenceHistoryResponse.fromJson(Map<String, dynamic> json) => AttendenceHistoryResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AttendanceLogData>.from(json["data"]!.map((x) => AttendanceLogData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AttendanceLogData {
  int? id;
  int? employeeId;
  DateTime? date;
  String? checkInTime;
  String? checkOutTime;
  String? checkInLatitude;
  String? checkInLongitude;
  String? checkOutLatitude;
  String? checkOutLongitude;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AttendanceLogData({
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

  factory AttendanceLogData.fromJson(Map<String, dynamic> json) => AttendanceLogData(
    id: json["id"],
    employeeId: json["employee_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    checkInTime: json["check_in_time"],
    checkOutTime: json["check_out_time"],
    checkInLatitude: json["check_in_latitude"],
    checkInLongitude: json["check_in_longitude"],
    checkOutLatitude: json["check_out_latitude"],
    checkOutLongitude: json["check_out_longitude"],
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

// To parse this JSON data, do
//
//     final attendenceSummaryResponse = attendenceSummaryResponseFromJson(jsonString);

import 'dart:convert';

AttendenceSummaryResponse attendenceSummaryResponseFromJson(String str) => AttendenceSummaryResponse.fromJson(json.decode(str));

String attendenceSummaryResponseToJson(AttendenceSummaryResponse data) => json.encode(data.toJson());

class AttendenceSummaryResponse {
  bool? status;
  String? message;
  Data? data;

  AttendenceSummaryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AttendenceSummaryResponse.fromJson(Map<String, dynamic> json) => AttendenceSummaryResponse(
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
  bool? checkedInToday;
  bool? checkedOutToday;
  Summary? summary;

  Data({
    this.checkedInToday,
    this.checkedOutToday,
    this.summary,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    checkedInToday: json["checked_in_today"],
    checkedOutToday: json["checked_out_today"],
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "checked_in_today": checkedInToday,
    "checked_out_today": checkedOutToday,
    "summary": summary?.toJson(),
  };
}

class Summary {
  int? totalDays;
  int? working;
  int? present;
  int? late;
  int? absent;

  Summary({
    this.totalDays,
    this.working,
    this.present,
    this.late,
    this.absent,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalDays: json["total_days"],
    working: json["working"],
    present: json["present"],
    late: json["late"],
    absent: json["absent"],
  );

  Map<String, dynamic> toJson() => {
    "total_days": totalDays,
    "working": working,
    "present": present,
    "late": late,
    "absent": absent,
  };
}

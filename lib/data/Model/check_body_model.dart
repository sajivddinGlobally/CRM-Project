// To parse this JSON data, do
//
//     final checkBodyModel = checkBodyModelFromJson(jsonString);

import 'dart:convert';

CheckBodyModel checkBodyModelFromJson(String str) => CheckBodyModel.fromJson(json.decode(str));

String checkBodyModelToJson(CheckBodyModel data) => json.encode(data.toJson());

class CheckBodyModel {
  double? latitude;
  double? longitude;

  CheckBodyModel({
    this.latitude,
    this.longitude,
  });

  factory CheckBodyModel.fromJson(Map<String, dynamic> json) => CheckBodyModel(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

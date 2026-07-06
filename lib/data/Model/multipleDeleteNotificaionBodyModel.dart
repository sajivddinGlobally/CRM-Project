// To parse this JSON data, do
//
//     final multipleDeleteNotificationBodyModel = multipleDeleteNotificationBodyModelFromJson(jsonString);

import 'dart:convert';

MultipleDeleteNotificationBodyModel multipleDeleteNotificationBodyModelFromJson(String str) => MultipleDeleteNotificationBodyModel.fromJson(json.decode(str));

String multipleDeleteNotificationBodyModelToJson(MultipleDeleteNotificationBodyModel data) => json.encode(data.toJson());

class MultipleDeleteNotificationBodyModel {
    List<int>? ids;

    MultipleDeleteNotificationBodyModel({
        this.ids,
    });

    factory MultipleDeleteNotificationBodyModel.fromJson(Map<String, dynamic> json) => MultipleDeleteNotificationBodyModel(
        ids: json["ids"] == null ? [] : List<int>.from(json["ids"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "ids": ids == null ? [] : List<dynamic>.from(ids!.map((x) => x)),
    };
}

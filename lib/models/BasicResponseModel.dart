// To parse this JSON data, do
//
//     final basicResponseModel = basicResponseModelFromJson(jsonString);

import 'dart:convert';

BasicResponseModel basicResponseModelFromJson(String str) => BasicResponseModel.fromJson(json.decode(str));

String basicResponseModelToJson(BasicResponseModel data) => json.encode(data.toJson());

class BasicResponseModel {
  BasicResponseModel({
    this.messge,
  });

  String messge;

  factory BasicResponseModel.fromJson(Map<String, dynamic> json) => BasicResponseModel(
    messge: json["messge"] == null ? null : json["messge"],
  );

  Map<String, dynamic> toJson() => {
    "messge": messge,
  };
}

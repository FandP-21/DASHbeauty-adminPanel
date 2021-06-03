// To parse this JSON data, do
//
//     final categoryResponseModel = categoryResponseModelFromJson(jsonString);

import 'dart:convert';

CategoryResponseModel categoryResponseModelFromJson(String str) => CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) => json.encode(data.toJson());

class CategoryResponseModel {
  CategoryResponseModel({
    this.data,
    this.totalReseult,
  });

  List<Datum> data;
  int totalReseult;

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
    data: json["data"] == null ? null :List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalReseult: json["TotalReseult"] == null ? null :json["TotalReseult"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "TotalReseult": totalReseult,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.image,
    this.isActive,
    this.isDeleted,
    this.createTime,
    this.updateTime,
  });

  int id;
  String name;
  String image;
  bool isActive;
  bool isDeleted;
  DateTime createTime;
  DateTime updateTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null :json["id"],
    name: json["name"] == null ? null :json["name"],
    image: json["image"] == null ? null :json["image"],
    isActive: json["isActive"] == null ? null :json["isActive"],
    isDeleted: json["isDeleted"] == null ? null :json["isDeleted"],
    createTime: json["createTime"] == null ? null :DateTime.parse(json["createTime"]),
    updateTime: json["updateTime"] == null ? null :DateTime.parse(json["updateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
  };
}

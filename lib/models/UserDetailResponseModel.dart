// To parse this JSON data, do
//
//     final userDetailResponseModel = userDetailResponseModelFromJson(jsonString);

import 'dart:convert';

UserDetailResponseModel userDetailResponseModelFromJson(String str) => UserDetailResponseModel.fromJson(json.decode(str));

String userDetailResponseModelToJson(UserDetailResponseModel data) => json.encode(data.toJson());

class UserDetailResponseModel {
  UserDetailResponseModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.roleId,
    this.storeId,
  });

  String userId;
  String firstName;
  String lastName;
  String email;
  int roleId;
  dynamic storeId;

  factory UserDetailResponseModel.fromJson(Map<String, dynamic> json) => UserDetailResponseModel(
    userId: json["userId"] == null ? null : json["userId"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    email: json["email"] == null ? null : json["email"],
    roleId: json["roleId"] == null ? null : json["roleId"],
    storeId: json["storeId"] == null ? null : json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "roleId": roleId,
    "storeId": storeId,
  };
}

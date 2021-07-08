// To parse this JSON data, do
//
//     final adminDashBoardResponse = adminDashBoardResponseFromJson(jsonString);

import 'dart:convert';

AdminDashBoardResponse adminDashBoardResponseFromJson(String str) => AdminDashBoardResponse.fromJson(json.decode(str));

String adminDashBoardResponseToJson(AdminDashBoardResponse data) => json.encode(data.toJson());

class AdminDashBoardResponse {
  AdminDashBoardResponse({
    this.users,
    this.activeUsers,
    this.deactiveUser,
    this.deletedUser,
    this.resellers,
    this.activeResellers,
    this.deactiveResellers,
    this.deletedResellers,
    this.orders,
    this.category,
  });

  int users;
  int activeUsers;
  int deactiveUser;
  int deletedUser;
  int resellers;
  int activeResellers;
  int deactiveResellers;
  int deletedResellers;
  int orders;
  int category;

  factory AdminDashBoardResponse.fromJson(Map<String, dynamic> json) => AdminDashBoardResponse(
    users: json["users"],
    activeUsers: json["activeUsers"],
    deactiveUser: json["deactiveUser"],
    deletedUser: json["deletedUser"],
    resellers: json["resellers"],
    activeResellers: json["activeResellers"],
    deactiveResellers: json["deactiveResellers"],
    deletedResellers: json["deletedResellers"],
    orders: json["orders"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "users": users,
    "activeUsers": activeUsers,
    "deactiveUser": deactiveUser,
    "deletedUser": deletedUser,
    "resellers": resellers,
    "activeResellers": activeResellers,
    "deactiveResellers": deactiveResellers,
    "deletedResellers": deletedResellers,
    "orders": orders,
    "category": category,
  };
}

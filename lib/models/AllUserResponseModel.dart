// To parse this JSON data, do
//
//     final allUserResponseModel = allUserResponseModelFromJson(jsonString);

import 'dart:convert';

AllUserResponseModel allUserResponseModelFromJson(String str) =>
    AllUserResponseModel.fromJson(json.decode(str));

String allUserResponseModelToJson(AllUserResponseModel data) =>
    json.encode(data.toJson());

class AllUserResponseModel {
  AllUserResponseModel({
    this.data,
    this.totalReseult,
  });

  List<UserResponseData> data;
  int totalReseult;

  factory AllUserResponseModel.fromJson(Map<String, dynamic> json) =>
      AllUserResponseModel(
        data: json["data"] == null
            ? null
            : List<UserResponseData>.from(json["data"].map((x) => UserResponseData.fromJson(x))),
        totalReseult:
            json["TotalReseult"] == null ? null : json["TotalReseult"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "TotalReseult": totalReseult,
      };
}

class UserResponseData {
  UserResponseData(
      {this.userId,
      this.roleId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.phoneNo,
      this.profilePic,
      this.storeId,
      this.timezone,
      this.status,
      this.isDeleted,
      this.isVerified,
      this.zipCode,
      this.gender,
      this.countryCode,
      this.title,
      this.preferredLanguage,
      this.preferredCurrency,
      this.registerVia,
      this.dob,
      this.createdBy,
      this.updatedBy,
      this.createdDate,
      this.updatedDate});

  String userId;
  int roleId;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phoneNo;
  String profilePic;
  String storeId;
  String timezone;
  int status;
  bool isDeleted;
  bool isVerified;
  String zipCode;
  String gender;
  String countryCode;
  String title;
  String preferredLanguage;
  String preferredCurrency;
  String registerVia;
  String dob;
  String createdBy;
  String updatedBy;
  DateTime createdDate;
  DateTime updatedDate;

  factory UserResponseData.fromJson(Map<String, dynamic> json) => UserResponseData(
        userId: json["userId"] == null ? null : json["userId"],
        roleId: json["roleId"] == null ? null : json["roleId"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"] == null ? null : json["email"],
        phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
        profilePic: json["profilePic"] == null ? null : json["profilePic"],
        storeId: json["storeId"] == null ? null : json["storeId"],
        timezone: json["timezone"] == null ? null : json["timezone"],
        status: json["status"] == null ? null : json["status"],
        isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
        isVerified: json["isVerified"] == null ? null : json["isVerified"],
        zipCode: json["zipCode"] == null ? null : json["zipCode"],
        gender: json["gender"] == null ? null : json["gender"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        title: json["title"] == null ? null : json["title"],
        preferredLanguage: json["preferredLanguage"] == null
            ? null
            : json["preferredLanguage"],
        preferredCurrency: json["preferredCurrency"] == null
            ? null
            : json["preferredCurrency"],
        registerVia: json["registerVia"] == null ? null : json["registerVia"],
        dob: json["dob"] == null ? null : json["dob"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        updatedDate: json["updatedDate"] == null
            ? null
            : DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "roleId": roleId,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "email": email,
        "phoneNo": phoneNo,
        "profilePic": profilePic,
        "storeId": storeId,
        "timezone": timezone,
        "status": status,
        "isDeleted": isDeleted,
        "isVerified": isVerified,
        "zipCode": zipCode,
        "gender": gender,
        "countryCode": countryCode,
        "title": title,
        "preferredLanguage": preferredLanguage,
        "preferredCurrency": preferredCurrency,
        "registerVia": registerVia,
        "dob": dob,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdDate": createdDate.toIso8601String(),
        "updatedDate": updatedDate.toIso8601String(),
      };
}

class UserRequest {
  String limit = "10";
  String page_no = "1";
  String search = "";
  String userRole = "3"; //send 2 for reseller, 3 for normal user

  UserRequest({this.limit, this.page_no, this.search, this.userRole});

  UserRequest.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page_no = json['page_no'];
    search = json['search'];
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page_no'] = this.page_no;
    data['search'] = this.search;
    data['userRole'] = this.userRole;
    return data;
  }
}



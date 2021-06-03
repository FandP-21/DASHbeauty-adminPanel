
class LoginResponseModel {
  LoginResponseModel({
    this.token,
  });

  String token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    token: json["token"] == null ?null :json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}


class LoginRequest {
  String username;
  String password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.message,
    required this.user,
  });

  String message;
  UserModel user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };
}

class UserModel {
  UserModel(
      {required this.email,
      required this.fullname,
      required this.image,
      required this.userType});

  String email;
  String fullname;
  String image;
  String userType;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json["Email"],
      fullname: json["Fullname"],
      image: json["Image"],
      userType: json["UserType"]);

  Map<String, dynamic> toJson() => {
        "Email": email,
        "Fullname": fullname,
        "Image": image,
        "UserType": userType
      };
}

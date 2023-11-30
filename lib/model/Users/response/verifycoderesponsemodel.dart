import 'dart:convert';

VerifyResponseModel verifyResponseModelFromJson(String str) =>
    VerifyResponseModel.fromJson(json.decode(str));

String verifyResponseModelToJson(VerifyResponseModel data) =>
    json.encode(data.toJson());

class VerifyResponseModel {
  User? user;
  String? token;
  String? error;

  VerifyResponseModel({
    this.user,
    this.token,
    this.error,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyResponseModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  int? id;
  String? username;
  dynamic password;
  String? email;
  String? phoneNumber;
  bool? isActive;

  User({
    this.id,
    this.username,
    this.password,
    this.email,
    this.phoneNumber,
    this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "email": email,
        "phone_number": phoneNumber,
        "is_active": isActive,
      };
}

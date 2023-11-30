// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
    String? token;
    User? user;

    RegisterResponseModel({
        this.token,
        this.user,
    });

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
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

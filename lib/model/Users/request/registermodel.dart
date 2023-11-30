import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String? username;
    String? email;
    String? phoneNumber;

    RegisterModel({
        this.username,
        this.email,
        this.phoneNumber,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
    };
}
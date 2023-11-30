import 'dart:convert';

RegisterResponseTaken registerResponseTakenFromJson(String str) => RegisterResponseTaken.fromJson(json.decode(str));

String registerResponseTakenToJson(RegisterResponseTaken data) => json.encode(data.toJson());

class RegisterResponseTaken {
    List<String>? username;
    List<String>? phoneNumber;

    RegisterResponseTaken({
        this.username,
        this.phoneNumber,
    });

    factory RegisterResponseTaken.fromJson(Map<String, dynamic> json) => RegisterResponseTaken(
        username: json["username"] == null ? [] : List<String>.from(json["username"]!.map((x) => x)),
        phoneNumber: json["phone_number"] == null ? [] : List<String>.from(json["phone_number"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "username": username == null ? [] : List<dynamic>.from(username!.map((x) => x)),
        "phone_number": phoneNumber == null ? [] : List<dynamic>.from(phoneNumber!.map((x) => x)),
    };
}
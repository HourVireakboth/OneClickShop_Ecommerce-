import 'dart:convert';

UserInformationTakenNameModel userInformationTakenNameModelFromJson(String str) => UserInformationTakenNameModel.fromJson(json.decode(str));

String userInformationTakenNameModelToJson(UserInformationTakenNameModel data) => json.encode(data.toJson());

class UserInformationTakenNameModel {
    List<String>? username;

    UserInformationTakenNameModel({
        this.username,
    });

    factory UserInformationTakenNameModel.fromJson(Map<String, dynamic> json) => UserInformationTakenNameModel(
        username: json["username"] == null ? [] : List<String>.from(json["username"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "username": username == null ? [] : List<dynamic>.from(username!.map((x) => x)),
    };
}
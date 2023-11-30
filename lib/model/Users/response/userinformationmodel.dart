import 'dart:convert';

UserInformationModel userInformationModelFromJson(String str) => UserInformationModel.fromJson(json.decode(str));

String userInformationModelToJson(UserInformationModel data) => json.encode(data.toJson());

class UserInformationModel {
    int? id;
    String? username;
    String? phoneNumber;
    String? email;
    String? image;

    UserInformationModel({
        this.id,
        this.username,
        this.phoneNumber,
        this.email,
        this.image,
       
    });

    factory UserInformationModel.fromJson(Map<String, dynamic> json) => UserInformationModel(
        id: json["id"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone_number": phoneNumber,
        "email": email,
        "image": image,
    };
}
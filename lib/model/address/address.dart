import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
    int? id;
    int? user;
    String? contactName;
    String? street;
    String? province;
    bool? thumbnail;

    AddressModel({
        this.id,
        this.user,
        this.contactName,
        this.street,
        this.province,
        this.thumbnail,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        user: json["user"],
        contactName: json["contact_name"],
        street: json["street"],
        province: json["province"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "contact_name": contactName,
        "street": street,
        "province": province,
        "thumbnail": thumbnail,
    };
}
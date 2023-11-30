import 'dart:convert';

AddCartModel addCartModelFromJson(String str) => AddCartModel.fromJson(json.decode(str));

String addCartModelToJson(AddCartModel data) => json.encode(data.toJson());

class AddCartModel {
    int? productId;
    int? quantity;
    String? color;
    String? size;
    String? image;

    AddCartModel({
        this.productId,
        this.quantity,
        this.color,
        this.size,
        this.image,
    });

    factory AddCartModel.fromJson(Map<String, dynamic> json) => AddCartModel(
        productId: json["product_id"],
        quantity: json["quantity"],
        color: json["color"],
        size: json["size"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "color": color,
        "size": size,
        "image": image,
    };
}
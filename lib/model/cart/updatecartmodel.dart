import 'dart:convert';

UpdataCartModel updataCartModelFromJson(String str) => UpdataCartModel.fromJson(json.decode(str));

String updataCartModelToJson(UpdataCartModel data) => json.encode(data.toJson());

class UpdataCartModel {
    int? productId;
    int? quantity;
    String? color;
    String? size;

    UpdataCartModel({
        this.productId,
        this.quantity,
        this.color,
        this.size,
    });

    factory UpdataCartModel.fromJson(Map<String, dynamic> json) => UpdataCartModel(
        productId: json["product_id"],
        quantity: json["quantity"],
        color: json["color"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "color": color,
        "size": size,
    };
}
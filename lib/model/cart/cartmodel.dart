// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

List<CartItemModel> cartItemModelFromJson(String str) =>
    List<CartItemModel>.from(
        json.decode(str).map((x) => CartItemModel.fromJson(x)));

String cartItemModelToJson(List<CartItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItemModel {
  int? id;
  CartItem? product;
  int? quantity;
  String? color;
  String? size;
  String? image;

  CartItemModel({
    this.id,
    this.product,
    this.quantity,
    this.color,
    this.size,
    this.image,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json["id"],
        product:json["product"] == null ? null : CartItem.fromJson(json["product"]),
        quantity: json["quantity"],
        color: json["color"],
        size: json["size"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "quantity": quantity,
        "color": color,
        "size": size,
        "image": image,
      };
}

class CartItem {
  int? id;
  String? name;
  String? description;
  String? price;
  Category? category;
  List<Images>? images;
  List<Stock>? stock;
  List<Category>? size;
  List<Category>? color;

  CartItem({
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.images,
    this.stock,
    this.size,
    this.color,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        stock: json["stock"] == null
            ? []
            : List<Stock>.from(json["stock"]!.map((x) => Stock.fromJson(x))),
        size: json["size"] == null
            ? []
            : List<Category>.from(
                json["size"]!.map((x) => Category.fromJson(x))),
        color: json["color"] == null
            ? []
            : List<Category>.from(
                json["color"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "stock": stock == null
            ? []
            : List<dynamic>.from(stock!.map((x) => x.toJson())),
        "size": size == null
            ? []
            : List<dynamic>.from(size!.map((x) => x.toJson())),
        "color": color == null
            ? []
            : List<dynamic>.from(color!.map((x) => x.toJson())),
      };
}

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Images {
  int? id;
  int? product;
  String? image;

  Images({
    this.id,
    this.product,
    this.image,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        product: json["product"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "image": image,
      };
}

class Stock {
  int? id;
  int? product;
  int? quantity;

  Stock({
    this.id,
    this.product,
    this.quantity,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        id: json["id"],
        product: json["product"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "quantity": quantity,
      };
}

// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

List<FavoriteModel> favoriteModelFromJson(String str) => List<FavoriteModel>.from(json.decode(str).map((x) => FavoriteModel.fromJson(x)));

String favoriteModelToJson(List<FavoriteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavoriteModel {
    int? id;
    int? user;
    int? product;
    ProductNested? productNested;

    FavoriteModel({
        this.id,
        this.user,
        this.product,
        this.productNested,
    });

    factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        user: json["user"],
        product: json["product"],
        productNested: json["product_nested"] == null ? null : ProductNested.fromJson(json["product_nested"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "product": product,
        "product_nested": productNested?.toJson(),
    };
}

class ProductNested {
    int? id;
    String? name;
    String? description;
    String? price;
    Category? category;
    List<Images>? images;
    List<dynamic>? stock;
    List<Category>? size;
    List<Category>? color;

    ProductNested({
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

    factory ProductNested.fromJson(Map<String, dynamic> json) => ProductNested(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        images: json["images"] == null ? [] : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        stock: json["stock"] == null ? [] : List<dynamic>.from(json["stock"]!.map((x) => x)),
        size: json["size"] == null ? [] : List<Category>.from(json["size"]!.map((x) => Category.fromJson(x))),
        color: json["color"] == null ? [] : List<Category>.from(json["color"]!.map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x)),
        "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x.toJson())),
        "color": color == null ? [] : List<dynamic>.from(color!.map((x) => x.toJson())),
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

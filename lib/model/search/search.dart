// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
    int? id;
    String? name;
    String? description;
    String? price;
    Category? category;
    List<Image>? images;
    List<Stock>? stock;
    List<Category>? size;
    List<ColorElement>? color;

    SearchModel({
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

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        stock: json["stock"] == null ? [] : List<Stock>.from(json["stock"]!.map((x) => Stock.fromJson(x))),
        size: json["size"] == null ? [] : List<Category>.from(json["size"]!.map((x) => Category.fromJson(x))),
        color: json["color"] == null ? [] : List<ColorElement>.from(json["color"]!.map((x) => ColorElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x.toJson())),
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

class Image {
    int? id;
    int? product;
    String? image;

    Image({
        this.id,
        this.product,
        this.image,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
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
class ColorElement {
    int? id;
    String? name;

    ColorElement({
        this.id,
        this.name,
    });

    factory ColorElement.fromJson(Map<String, dynamic> json) => ColorElement(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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

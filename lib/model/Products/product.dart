// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int? pageSize;
  int? totalObjects;
  int? totalPages;
  int? currentPageNumber;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  ProductModel({
    this.pageSize,
    this.totalObjects,
    this.totalPages,
    this.currentPageNumber,
    this.next,
    this.previous,
    this.results,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        pageSize: json["page_size"],
        totalObjects: json["total_objects"],
        totalPages: json["total_pages"],
        currentPageNumber: json["current_page_number"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page_size": pageSize,
        "total_objects": totalObjects,
        "total_pages": totalPages,
        "current_page_number": currentPageNumber,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  String? name;
  String? description;
  String? price;
  Category? category;
  List<Images>? images;
  List<dynamic>? stock;
  List<Category>? size;
  List<ColorElement>? color;

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      images: json["images"] == null
          ? []
          : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
      stock: json["stock"] == null
          ? []
          : List<dynamic>.from(json["stock"]!.map((x) => x)),
      size: json["size"] == null
          ? []
          : List<Category>.from(json["size"]!.map((x) => Category.fromJson(x))),
      color: json["color"] == null
          ? []
          : List<ColorElement>.from(json["color"]!.map((x) => ColorElement.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x)),
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

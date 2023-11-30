// To parse this JSON data, do
//
//     final showOrderRecordModel = showOrderRecordModelFromJson(jsonString);

import 'dart:convert';

ShowOrderRecordModel showOrderRecordModelFromJson(String str) => ShowOrderRecordModel.fromJson(json.decode(str));

String showOrderRecordModelToJson(ShowOrderRecordModel data) => json.encode(data.toJson());

class ShowOrderRecordModel {
    int? pageSize;
    int? totalObjects;
    int? totalPages;
    int? currentPageNumber;
    dynamic next;
    dynamic previous;
    List<ResultOrders>? resultOrders;

    ShowOrderRecordModel({
        this.pageSize,
        this.totalObjects,
        this.totalPages,
        this.currentPageNumber,
        this.next,
        this.previous,
        this.resultOrders,
    });

    factory ShowOrderRecordModel.fromJson(Map<String, dynamic> json) => ShowOrderRecordModel(
        pageSize: json["page_size"],
        totalObjects: json["total_objects"],
        totalPages: json["total_pages"],
        currentPageNumber: json["current_page_number"],
        next: json["next"],
        previous: json["previous"],
        resultOrders: json["results"] == null ? [] : List<ResultOrders>.from(json["results"]!.map((x) => ResultOrders.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page_size": pageSize,
        "total_objects": totalObjects,
        "total_pages": totalPages,
        "current_page_number": currentPageNumber,
        "next": next,
        "previous": previous,
        "results": resultOrders == null ? [] : List<dynamic>.from(resultOrders!.map((x) => x.toJson())),
    };
}

class ResultOrders {
    int? id;
    Order? order;
    Product? product;
    int? quantity;
    String? total;
    String? colorId;
    String? sizeId;
    String? imageId;

    ResultOrders({
        this.id,
        this.order,
        this.product,
        this.quantity,
        this.total,
        this.colorId,
        this.sizeId,
        this.imageId,
    });

    factory ResultOrders.fromJson(Map<String, dynamic> json) => ResultOrders(
        id: json["id"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"],
        total: json["total"],
        colorId: json["color_id"],
        sizeId: json["size_id"],
        imageId: json["image_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order": order?.toJson(),
        "product": product?.toJson(),
        "quantity": quantity,
        "total": total,
        "color_id": colorId,
        "size_id": sizeId,
        "image_id": imageId,
    };
}

class Order {
    int? id;
    String? contactName;
    String? street;
    String? orderNo;
    String? status;
    DateTime? createdAt;
    DateTime? pendingDate;
    DateTime? shippedDate;
    DateTime? deliveredDate;
    int? user;

    Order({
        this.id,
        this.contactName,
        this.street,
        this.orderNo,
        this.status,
        this.createdAt,
        this.pendingDate,
        this.shippedDate,
        this.deliveredDate,
        this.user,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        contactName: json["contact_name"],
        street: json["street"],
        orderNo: json["order_no"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        pendingDate: json["pending_date"] == null ? null : DateTime.parse(json["pending_date"]),
        shippedDate: json["shipped_date"] == null ? null : DateTime.parse(json["shipped_date"]),
        deliveredDate: json["delivered_date"] == null ? null : DateTime.parse(json["delivered_date"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contact_name": contactName,
        "street": street,
        "order_no": orderNo,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "pending_date": pendingDate?.toIso8601String(),
        "shipped_date": shippedDate?.toIso8601String(),
        "delivered_date": deliveredDate?.toIso8601String(),
        "user": user,
    };
}

class Product {
    int? id;
    String? name;
    String? description;
    String? price;
    Category? category;
    List<Images>? images;
    List<Stock>? stock;
    List<Category>? size;
    List<Category>? color;

    Product({
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

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        images: json["images"] == null ? [] : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        stock: json["stock"] == null ? [] : List<Stock>.from(json["stock"]!.map((x) => Stock.fromJson(x))),
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

// To parse this JSON data, do
//
//     final makePaymentModel = makePaymentModelFromJson(jsonString);

import 'dart:convert';

MakePaymentModel makePaymentModelFromJson(String str) => MakePaymentModel.fromJson(json.decode(str));

String makePaymentModelToJson(MakePaymentModel data) => json.encode(data.toJson());

class MakePaymentModel {
    int? id;
    int? user;
    String? contactName;
    String? street;
    String? province;
    String? createdAt;
    String? orderNo;
    String? status;
    DateTime? pendingDate;
    DateTime? shippedDate;
    DateTime? deliveredDate;

    MakePaymentModel({
        this.id,
        this.user,
        this.contactName,
        this.street,
        this.province,
        this.createdAt,
        this.orderNo,
        this.status,
        this.pendingDate,
        this.shippedDate,
        this.deliveredDate,
    });

    factory MakePaymentModel.fromJson(Map<String, dynamic> json) => MakePaymentModel(
        id: json["id"],
        user: json["user"],
        contactName: json["contact_name"],
        street: json["street"],
        province: json["province"],
        createdAt: json["created_at"],
        orderNo: json["order_no"],
        status: json["status"],
        pendingDate: json["pending_date"] == null ? null : DateTime.parse(json["pending_date"]),
        shippedDate: json["shipped_date"] == null ? null : DateTime.parse(json["shipped_date"]),
        deliveredDate: json["delivered_date"] == null ? null : DateTime.parse(json["delivered_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "contact_name": contactName,
        "street": street,
        "province": province,
        "created_at": createdAt,
        "order_no": orderNo,
        "status": status,
        "pending_date": pendingDate?.toIso8601String(),
        "shipped_date": shippedDate?.toIso8601String(),
        "delivered_date": deliveredDate?.toIso8601String(),
    };
}

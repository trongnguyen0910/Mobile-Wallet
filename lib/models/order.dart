// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
    Order({
        required this.data,
    });

    OrderProduct data;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        data: OrderProduct.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class OrderProduct {
    OrderProduct({
        required this.transOrderId,
        required this.transOrderDate,
        required this.totalAmount,
        required this.customerId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.fullName,
    });

    String transOrderId;
    DateTime transOrderDate;
    int totalAmount;
    String customerId;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String fullName;
    factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        transOrderId: json["trans_order_id"],
        transOrderDate: DateTime.parse(json["trans_order_date"]),
        totalAmount: json["total_amount"],
        customerId: json["customer_id"],
        status: json["status"],
        fullName: json["fullName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );



    Map<String, dynamic> toJson() => {
        "trans_order_id": transOrderId,
        "trans_order_date": transOrderDate.toIso8601String(),
        "total_amount": totalAmount,
        "customer_id": customerId,
        "status": status,
        "fullName":fullName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

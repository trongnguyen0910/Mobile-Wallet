// To parse this JSON data, do
//
//     final wallet = walletFromJson(jsonString);

import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
    Wallet({
        required this.data,
    });

    List<Walletcus> data;

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        data: List<Walletcus>.from(json["data"].map((x) => Walletcus.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Walletcus {
    Walletcus({
        required this.walletId,
        required this.balance,
        required this.walletTypeName,
        required this.customerId,
        required this.status,
    });

    String walletId;
    double balance;
    String walletTypeName;
    String customerId;
    String status;

    factory Walletcus.fromJson(Map<String, dynamic> json) => Walletcus(
        walletId: json["wallet_id"],
        balance: json["balance"]?.toDouble(),
        walletTypeName: json["wallet_type_name"],
        customerId: json["customer_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "wallet_id": walletId,
        "balance": balance,
        "wallet_type_name": walletTypeName,
        "customer_id": customerId,
        "status": status,
    };
}

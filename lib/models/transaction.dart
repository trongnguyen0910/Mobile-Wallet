// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    TransactionModel({
        required this.page,
        required this.totalPage,
        required this.data,
    });

    int page;
    int totalPage;
    List<TransactionWallet> data;

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        page: json["page"],
        totalPage: json["total_page"],
        data: List<TransactionWallet>.from(json["data"].map((x) => TransactionWallet.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "total_page": totalPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TransactionWallet {
    TransactionWallet({
        required this.transId,
        required this.amount,
        required this.transactionDate,
        required this.code,
        required this.walletId,
        required this.partnerRequestId,
        this.transOrderId,
        required this.description,
        required this.transFrom,
        required this.transTo,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        this.content,
    });

    String transId;
    int amount;
    DateTime transactionDate;
    String code;
    String walletId;
    String partnerRequestId;
    String? transOrderId;
    String description;
    String transFrom;
    String transTo;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String? content;

    factory TransactionWallet.fromJson(Map<String, dynamic> json) => TransactionWallet(
        transId: json["trans_id"],
        amount: json["amount"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        code: json["code"],
        walletId: json["wallet_id"],
        partnerRequestId: json["partner_request_id"],
        transOrderId: json["trans_order_id"],
        description: json["description"],
        transFrom: json["trans_from"],
        transTo: json["trans_to"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "trans_id": transId,
        "amount": amount,
        "transaction_date": transactionDate.toIso8601String(),
        "code": code,
        "wallet_id": walletId,
        "partner_request_id": partnerRequestId,
        "trans_order_id": transOrderId,
        "description": description,
        "trans_from": transFrom,
        "trans_to": transTo,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "content": content,
    };
}

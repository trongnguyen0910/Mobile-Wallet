// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
    Person({
        required this.accessToken,
        required this.refreshToken,
        required this.data,
        required this.message,
    });

    String accessToken;
    String refreshToken;
    Data data;
    String message;

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.avatar,
        required this.role,
        required this.wallet,
    });

    String id;
    String name;
    String email;
    String phone;
    String avatar;
    String role;
    Wallet wallet;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        role: json["role"],
        wallet: Wallet.fromJson(json["wallet"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "role": role,
        "wallet": wallet.toJson(),
    };
}

class Wallet {
    Wallet({
        required this.id,
        required this.walletBalance,
        required this.walletType,
    });

    String id;
    int walletBalance;
    String walletType;

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        walletBalance: json["wallet_balance"],
        walletType: json["wallet_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "wallet_balance": walletBalance,
        "wallet_type": walletType,
    };
}

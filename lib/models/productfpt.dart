// To parse this JSON data, do
//
//     final productFpt = productFptFromJson(jsonString);

import 'dart:convert';

ProductFpt productFptFromJson(String str) => ProductFpt.fromJson(json.decode(str));

String productFptToJson(ProductFpt data) => json.encode(data.toJson());

class ProductFpt {
    ProductFpt({
        required this.metadata,
        required this.data,
        required this.cache,
    });

    Metadata metadata;
    List<Datum> data;
    bool cache;

    factory ProductFpt.fromJson(Map<String, dynamic> json) => ProductFpt(
        metadata: Metadata.fromJson(json["metadata"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        cache: json["cache"],
    );

    Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "cache": cache,
    };
}

class Datum {
    Datum({
        required this.productId,
        required this.productName,
        this.image,
        required this.productPrice,
        // required this.description,
        this.quantity,
        required this.categoryId,
        this.code,
        this.updatedBy,
        this.dateFrom,
        this.dateTo,
        
        this.createdAt,
        this.updatedAt,
    });

    String productId;
    String productName;
    String? image;
    int productPrice;
    // Description description;
    int? quantity;
    String categoryId;
    String? code;
    String? updatedBy;
    DateTime? dateFrom;
    DateTime? dateTo;
    
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json){
      return Datum(
        productId: json["product_id"],
        productName: json["product_name"],
        image: json["image"],
        productPrice: json["product_price"],
        // description: descriptionValues.map[json["description"]]!,
        quantity: json["quantity"],
        categoryId: json["category_id"],
        code: json["code"],
        updatedBy: json["updatedBy"],
        dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
        dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),
        
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );
    }
    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "image": image,
        "product_price": productPrice,
        // "description": descriptionValues.reverse[description],
        "quantity": quantity,
        "category_id": categoryId,
        "code": code,
        "updatedBy": updatedBy,
        "dateFrom": dateFrom?.toIso8601String(),
        "dateTo": dateTo?.toIso8601String(),
        
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

enum Description { SN_PHM_C_TI_TR_BI_FPT }

final descriptionValues = EnumValues({
    "Sản phẩm được tài trợ bởi FPT": Description.SN_PHM_C_TI_TR_BI_FPT
});

enum Status { ACTIVE }

final statusValues = EnumValues({
    "active": Status.ACTIVE
});

class Metadata {
    Metadata({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.totalPages,
    });

    int page;
    int perPage;
    int totalItems;
    int totalPages;

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "totalPages": totalPages,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<BrandModel> brandModelFromJson(String str) =>
    List<BrandModel>.from(json.decode(str).map((x) => BrandModel.fromJson(x)));

String brandModelToJson(List<BrandModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandModel {
  BrandModel({
    required this.id,
   required this.brand,
   required this.name,
   required this.price,
   required this.priceSign,
   required this.currency,
   required this.imageLink,
   required this.productLink,
   required this.websiteLink,
  required  this.description,
  required  this.rating,
   required this.category,
   required this.productType,
   required this.tagList,
   required this.createdAt,
   required this.updatedAt,
  required  this.productApiUrl,
   required this.apiFeaturedImage,
   required this.productColors,
  });

  final int id;
  final String brand;
  final String name;
  final String price;
  final dynamic priceSign;
  final dynamic currency;
  final String imageLink;
  final String productLink;
  final String websiteLink;
  final String description;
  final double? rating;
  final String? category;
  final String productType;
  final List<String> tagList;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String productApiUrl;
  final String apiFeaturedImage;
  final List<ProductColor> productColors;

var isFavorite = false.obs;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["id"],
        brand: json["brand"].toString(),
        name: json["name"],
        price: json["price"].toString(),
        priceSign: json["price_sign"] == null
            ? null
            : priceSignValues.map[json["price_sign"]],
        currency: json["currency"] == null
            ? null
            : currencyValues.map[json["currency"]],
        imageLink: json["image_link"],
        productLink: json["product_link"],
        websiteLink: json["website_link"],
        description: json["description"].toString(),
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        category: json["category"],
        productType: json["product_type"],
        tagList: List<String>.from(json["tag_list"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productApiUrl: json["product_api_url"],
        apiFeaturedImage: json["api_featured_image"],
        productColors: List<ProductColor>.from(
            json["product_colors"].map((x) => ProductColor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "name": name,
        "price": price,
        "price_sign":
            priceSign == null ? null : priceSignValues.reverse[priceSign],
        "currency": currency == null ? null : currencyValues.reverse[currency],
        "image_link": imageLink,
        "product_link": productLink,
        "website_link": websiteLink,
        "description": description,
        "rating": rating,
        "category": category == null ? null : categoryValues.reverse[category],
        "product_type": productTypeValues.reverse[productType],
        "tag_list": List<dynamic>.from(tagList.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_api_url": productApiUrl,
        "api_featured_image": apiFeaturedImage,
        "product_colors":
            List<dynamic>.from(productColors.map((x) => x.toJson())),
      };
}

enum Category {
  PENCIL,
  LIPSTICK,
  LIQUID,
  EMPTY,
  POWDER,
  LIP_GLOSS,
  GEL,
  CREAM,
  PALETTE,
  CONCEALER,
  HIGHLIGHTER,
  BB_CC,
  CONTOUR,
  LIP_STAIN,
  MINERAL
}

final categoryValues = EnumValues({
  "bb_cc": Category.BB_CC,
  "concealer": Category.CONCEALER,
  "contour": Category.CONTOUR,
  "cream": Category.CREAM,
  "": Category.EMPTY,
  "gel": Category.GEL,
  "highlighter": Category.HIGHLIGHTER,
  "lipstick": Category.LIPSTICK,
  "lip_gloss": Category.LIP_GLOSS,
  "lip_stain": Category.LIP_STAIN,
  "liquid": Category.LIQUID,
  "mineral": Category.MINERAL,
  "palette": Category.PALETTE,
  "pencil": Category.PENCIL,
  "powder": Category.POWDER
});

enum Currency { CAD, USD, GBP }

final currencyValues =
    EnumValues({"CAD": Currency.CAD, "GBP": Currency.GBP, "USD": Currency.USD});

enum PriceSign { EMPTY, PRICE_SIGN }

final priceSignValues =
    EnumValues({"\u0024": PriceSign.EMPTY, "£": PriceSign.PRICE_SIGN});

class ProductColor {
  ProductColor({
    required this.hexValue,
    required this.colourName,
  });

  final String hexValue;
  final String? colourName;

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
        hexValue: json["hex_value"],
        colourName: json["colour_name"],
      );

  Map<String, dynamic> toJson() => {
        "hex_value": hexValue,
        "colour_name": colourName,
      };
}

enum ProductType {
  LIP_LINER,
  LIPSTICK,
  FOUNDATION,
  EYELINER,
  EYESHADOW,
  BLUSH,
  BRONZER,
  MASCARA,
  EYEBROW,
  NAIL_POLISH
}

final productTypeValues = EnumValues({
  "blush": ProductType.BLUSH,
  "bronzer": ProductType.BRONZER,
  "eyebrow": ProductType.EYEBROW,
  "eyeliner": ProductType.EYELINER,
  "eyeshadow": ProductType.EYESHADOW,
  "foundation": ProductType.FOUNDATION,
  "lipstick": ProductType.LIPSTICK,
  "lip_liner": ProductType.LIP_LINER,
  "mascara": ProductType.MASCARA,
  "nail_polish": ProductType.NAIL_POLISH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}

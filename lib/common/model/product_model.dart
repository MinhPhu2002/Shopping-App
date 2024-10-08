import 'package:flutter/foundation.dart';

class ProductModel {
  final int id;
  final String title;
  final String imageUrl;
  final String price;
  factory ProductModel.formJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        imageUrl: removeCharacter(json['images'][0]),
        price: json['price'].toString());
  }
  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}

String removeCharacter(String text) {
  text = text.replaceAll('[', '');
  text = text.replaceAll(']', '');
  text = text.replaceAll('"', '');
  return text;
}

class ProductDetailsModel {
  final int id;
  final String title;
  final List<String> imageUrl;
  final String price;
  final String description;
  final String thumbnail;
  final List<ProductColor> productColors;
  final List<ProductSize> productSizes;
  final List<Variant> variants;

  ProductDetailsModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.description,
      required this.thumbnail,
      required this.variants,
      required this.productColors,
      required this.productSizes});
  factory ProductDetailsModel.formJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title'],
      imageUrl: List.castFrom(json['images']),
      price: json['price'].toString(),
      description: json['description'],
      thumbnail: json['thumbnail'],
      variants: (json['variants'] as List)
          .map((variant) => Variant.formJson(variant))
          .toList(),
      productColors: (json['options'][0]['values'] as List)
          .map((color) => ProductColor.formJson(color))
          .toList(),
      productSizes: (json['options'][1]['values'] as List)
          .map((size) => ProductSize.formJson(size))
          .toList(),
    );
  }
}

class ProductSize {
  final int id;
  final String name;

  ProductSize({required this.id, required this.name});
  factory ProductSize.formJson(Map<String, dynamic> json) {
    return ProductSize(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductColor {
  final int id;
  final String name;
  final String colorCode;

  ProductColor({required this.id, required this.name, required this.colorCode});
  factory ProductColor.formJson(Map<String, dynamic> json) {
    return ProductColor(
      id: json['id'],
      name: json['name'],
      colorCode: json['colorCode'],
    );
  }
}

class Variant {
  final int id;
  final List<int> option_ids;
  final int stock;

  Variant({required this.id, required this.option_ids, required this.stock});
  factory Variant.formJson(Map<String, dynamic> json) {
    return Variant(
        id: json['id'],
        option_ids: List.castFrom(json['option_ids']),
        stock: json['stock']);
  }
}

class ProductCartModel {
  final int id;
  final String title;
  final String thumbnail;
  final String price;
  factory ProductCartModel.formJson(Map<String, dynamic> json) {
    return ProductCartModel(
        id: json['id'],
        title: json['title'],
        thumbnail: json['thumbnail'],
        price: json['price'].toString());
  }
  ProductCartModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });
}

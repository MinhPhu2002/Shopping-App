import 'dart:convert';

class BrandDetailsModel {
  final int id;
  final String name;
  final String imageUrl;
  final String price;
  final String nameBrand;
  factory BrandDetailsModel.formJson(Map<String, dynamic> json) {
    return BrandDetailsModel(
      id: json['id'],
      name: json['title'],
      imageUrl: json['images'][0],
      price: json['price'].toString(),
      nameBrand: json['category']['name'],
    );
  }

  BrandDetailsModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.nameBrand});
}

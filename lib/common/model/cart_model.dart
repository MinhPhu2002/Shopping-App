import 'package:testapp/common/model/product_model.dart';

class CartModel {
  final int id;
  final double total;
  final List<ProductCartModel> products;

  CartModel({required this.id, required this.total, required this.products});
  factory CartModel.formJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      total: json['total'],
      products: List.of(json['products'])
          .map(
            (e) => ProductCartModel.formJson(e),
          )
          .toList(),
    );
  }
}

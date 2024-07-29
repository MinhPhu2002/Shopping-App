import 'package:testapp/common/model/cart_model.dart';

class CartState {}

class CartLoadingInProgress extends CartState {}

class CartLoaded extends CartState {
  final CartModel cart;

  CartLoaded({required this.cart});
}

class CartLoadingError extends CartState {
  final String errorMessage;

  CartLoadingError({required this.errorMessage});
}

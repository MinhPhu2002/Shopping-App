import 'package:testapp/common/model/product_model.dart';
import 'package:testapp/module/home/bloc/products/products_state.dart';

abstract class ProductDetailsState {}

class ProductDetailsLoadingInProgress extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsModel productDetails;
  ProductDetailsLoaded({required this.productDetails});
}

class ProductDetailsLoadingError extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsLoadingError({required this.errorMessage});
}

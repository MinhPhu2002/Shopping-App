import 'package:testapp/common/model/product_model.dart';

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

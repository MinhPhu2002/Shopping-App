import 'package:testapp/common/model/product_model.dart';

abstract class ProductsState {}

class ProductsLoadingInProgress extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;

  ProductsLoaded({required this.products});
}

class ProductsLoadingError extends ProductsState {
  final String errorMessage;

  ProductsLoadingError({required this.errorMessage});
}

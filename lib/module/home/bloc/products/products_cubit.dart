import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/home/bloc/products/products_state.dart';
import 'package:testapp/module/home/repo/product_repo.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoadingInProgress()) {
    load();
  }
  final ProductsRepository repo = ProductsRepository();
  Future<void> load() async {
    try {
      emit(ProductsLoadingInProgress());
      final result = await repo.getProducts(0, 10);
      emit(ProductsLoaded(products: result));
    } catch (e) {
      emit(ProductsLoadingError(errorMessage: e.toString()));
    }
  }
}

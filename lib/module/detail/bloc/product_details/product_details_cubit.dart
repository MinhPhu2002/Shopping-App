import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/detail/bloc/product_details/product_details_state.dart';
import 'package:testapp/module/home/repo/product_repo.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final int id;
  ProductDetailsCubit(this.id) : super(ProductDetailsLoadingInProgress()) {
    load();
  }
  final ProductsRepository repo = ProductsRepository();
  Future<void> load() async {
    try {
      emit(ProductDetailsLoadingInProgress());
      final result = await repo.getProductDetails(id);
      emit(ProductDetailsLoaded(productDetails: result));
    } catch (e) {
      emit(ProductDetailsLoadingError(errorMessage: e.toString()));
    }
  }
}

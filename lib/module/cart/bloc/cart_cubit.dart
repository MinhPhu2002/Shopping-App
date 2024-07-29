import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/cart/bloc/cart_state.dart';
import 'package:testapp/module/cart/repo/cart_repo.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoadingInProgress()) {
    load();
  }
  final CartRepository repo = CartRepository();
  Future<void> load() async {
    try {
      emit(CartLoadingInProgress());
      final result = await repo.getCart();
      emit(CartLoaded(cart: result));
    } catch (e) {
      emit(CartLoadingError(errorMessage: e.toString()));
    }
  }
}

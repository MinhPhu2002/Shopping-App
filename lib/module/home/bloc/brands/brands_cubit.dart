import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/home/bloc/brands/brands_state.dart';
import 'package:testapp/module/home/repo/brand_repo.dart';

class BrandsCubit extends Cubit<BrandsState> {
  BrandsCubit() : super(BrandsLoadingInProgress()) {
    load();
  }
  final BrandRepository repo = BrandRepository();
  Future<void> load() async {
    try {
      emit(BrandsLoadingInProgress());
      final result = await repo.getBrands();
      emit(BrandsLoaded(brands: result));
    } catch (e) {
      emit(BrandsLoadingError(errorMessage: e.toString()));
    }
  }
}

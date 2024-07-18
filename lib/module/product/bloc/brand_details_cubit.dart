import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/home/repo/brand_repo.dart';
import 'package:testapp/module/product/bloc/brand_details_state.dart';

class BrandDetailsCubit extends Cubit<BrandDetailsState> {
  final int id;

  BrandDetailsCubit(this.id) : super(BrandDetailsLoadingInProgress()) {
    load();
  }
  final BrandRepository repo = BrandRepository();
  Future<void> load() async {
    try {
      emit(BrandDetailsLoadingInProgress());
      final result = await repo.getBrandDetails(id);
      emit(BrandDetailsLoaded(brandDetails: result));
    } catch (e) {
      emit(BrandDetailsLoadingError(errorMessage: e.toString()));
    }
  }
}

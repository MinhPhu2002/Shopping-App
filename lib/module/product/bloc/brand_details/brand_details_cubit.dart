import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/module/home/repo/brand_repo.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_state.dart';

class BrandDetailsCubit extends Cubit<BrandDetailsState> {
  final int id;

  BrandDetailsCubit(this.id) : super(BrandDetailsState(isLoading: true)) {
    load();
  }
  int offset = 0;
  final BrandRepository repo = BrandRepository();
  Future<void> load() async {
    try {
      emit(BrandDetailsState(isLoading: true));
      final result = await repo.getBrandDetails(id, limit: 6, offset: offset);
      emit(BrandDetailsState(
          isLoading: false,
          brandDetails: result.brandDetailsModel,
          totalItemCount: result.totalItemCount));
    } catch (e) {
      emit(BrandDetailsState(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> loadMore() async {
    offset = offset + 6;
    try {
      emit(BrandDetailsState(
          isLoading: true,
          brandDetails: state.brandDetails,
          totalItemCount: state.totalItemCount));
      final result = await repo.getBrandDetails(id, limit: 10, offset: offset);
      emit(BrandDetailsState(
          totalItemCount: result.totalItemCount,
          isLoading: false,
          brandDetails: [...?state.brandDetails, ...result.brandDetailsModel]));
    } catch (e) {
      emit(BrandDetailsState(
          isLoading: false,
          errorMessage: e.toString(),
          brandDetails: state.brandDetails,
          totalItemCount: state.totalItemCount));
    }
  }

  final ApiClient apiClient = ApiClient();
}

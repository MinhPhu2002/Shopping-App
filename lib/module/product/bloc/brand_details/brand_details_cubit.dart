import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/common/model/products_filter_model.dart';
import 'package:testapp/core/values/sort_product_by.dart';
import 'package:testapp/module/home/repo/brand_repo.dart';
import 'package:testapp/module/product/bloc/brand_details/brand_details_state.dart';

class BrandDetailsCubit extends Cubit<BrandDetailsState> {
  final String slug;

  BrandDetailsCubit(this.slug)
      : super(BrandDetailsState(
          isLoading: true,
          hasMoreItem: true,
        )) {
    load();
  }
  int skip = 0;
  final BrandRepository repo = BrandRepository();
  ProductsFilterModel productsFilterModel = ProductsFilterModel();
  Future<void> load() async {
    try {
      emit(BrandDetailsState(isLoading: true, hasMoreItem: true));
      final result = await repo.getBrandDetails(slug,
          limit: 6,
          skip: skip,
          sortBy: productsFilterModel.sortBy,
          order: productsFilterModel.order,
          price: productsFilterModel.priceName);
      emit(BrandDetailsState(
          isLoading: false,
          brandDetails: result.brandDetailsModel,
          totalItemCount: result.totalItemCount,
          hasMoreItem: result.totalItemCount > 6));
    } catch (e) {
      emit(BrandDetailsState(
          isLoading: false, errorMessage: e.toString(), hasMoreItem: true));
    }
  }

  Future<void> loadMore() async {
    if (skip >= (state.totalItemCount ?? 0)) {
      return;
    }
    emit(BrandDetailsState(
      isLoading: true,
      hasMoreItem: state.hasMoreItem,
      brandDetails: state.brandDetails,
      totalItemCount: state.totalItemCount,
    ));
    skip = skip + 6;
    try {
      final result = await repo.getBrandDetails(slug,
          limit: 6,
          skip: skip,
          sortBy: productsFilterModel.sortBy,
          order: productsFilterModel.order,
          price: productsFilterModel.priceName);

      emit(BrandDetailsState(
          totalItemCount: result.totalItemCount,
          isLoading: false,
          brandDetails: [...?state.brandDetails, ...result.brandDetailsModel],
          hasMoreItem: result.totalItemCount > skip + 6));
    } catch (e) {
      skip -= 6;
      emit(BrandDetailsState(
          isLoading: false,
          errorMessage: e.toString(),
          brandDetails: state.brandDetails,
          totalItemCount: state.totalItemCount,
          hasMoreItem: state.hasMoreItem));
    }
  }

  Future<void> sort(SortProductBy? sortBy) async {
    productsFilterModel = productsFilterModel.sort(sortProductBy: sortBy);
    skip = 0;
    return load();
  }

  Future<void> filter({String? priceFrom, String? priceTo}) async {
    productsFilterModel =
        productsFilterModel.filter(priceFrom: priceFrom, priceTo: priceTo);
    // print(productsFilterModel.priceName);
    skip = 0;
    return load();
  }

  // final ApiClient apiClient = ApiClient();
}

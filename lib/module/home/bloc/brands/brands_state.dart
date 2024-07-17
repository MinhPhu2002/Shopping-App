import 'package:testapp/common/model/brand_model.dart';

abstract class BrandsState {}

class BrandsLoadingInProgress extends BrandsState {}

class BrandsLoaded extends BrandsState {
  final List<BrandModel> brands;

  BrandsLoaded({required this.brands});
}

class BrandsLoadingError extends BrandsState {
  final String errorMessage;

  BrandsLoadingError({required this.errorMessage});
}

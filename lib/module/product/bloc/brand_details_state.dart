import 'package:testapp/common/model/brand_details_model.dart';

class BrandDetailsState {}

class BrandDetailsLoadingInProgress extends BrandDetailsState {}

class BrandDetailsLoaded extends BrandDetailsState {
  final List<BrandDetailsModel> brandDetails;

  BrandDetailsLoaded({required this.brandDetails});
}

class BrandDetailsLoadingError extends BrandDetailsState {
  final String errorMessage;

  BrandDetailsLoadingError({required this.errorMessage});
}

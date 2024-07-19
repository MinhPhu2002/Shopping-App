import 'package:testapp/common/model/brand_details_model.dart';

class BrandDetailsState {
  final List<BrandDetailsModel>? brandDetails;
  final String? errorMessage;
  final bool isLoading;

  BrandDetailsState({
    this.totalItemCount,
    this.brandDetails,
    this.errorMessage,
    required this.isLoading,
  });
  final int? totalItemCount;
}

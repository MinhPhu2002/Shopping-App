import 'package:testapp/common/model/brand_details_model.dart';
import 'package:testapp/common/model/brand_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';

class BrandRepository {
  Future<List<BrandModel>> getBrands() async {
    final RequestResponse result = await apiClient.fetch(
      ApiPath.getBrands,
      RequestMethod.get,
    );

    return result.jsonArray.map((json) {
      return BrandModel.formJson(json);
    }).toList();
  }

  Future<BrandDetailsResponse> getBrandDetails(String slug,
      {required int limit,
      required int skip,
      required String? sortBy,
      required String? order,
      required String? price}) async {
    final RequestResponse result = await apiClient.fetch(
        ApiPath.getBrandDetails + "$slug", RequestMethod.get,
        searchParams: {
          'limit': limit.toString(),
          'skip': skip.toString(),
          if (sortBy != null) 'sortBy': sortBy,
          if (order != null) 'order': order,
          if (price != null) 'price': price,
        });
    final int totalItemCount = result.json['total'];
    final List products = result.json['products'];
    return BrandDetailsResponse(
        brandDetailsModel: products.map((json) {
          return BrandDetailsModel.formJson(json);
        }).toList(),
        totalItemCount: totalItemCount);
  }

  final ApiClient apiClient = ApiClient();
}

class BrandDetailsResponse {
  final List<BrandDetailsModel> brandDetailsModel;
  final int totalItemCount;

  BrandDetailsResponse(
      {required this.brandDetailsModel, required this.totalItemCount});
}

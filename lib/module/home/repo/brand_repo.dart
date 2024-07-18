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
      searchParams: {
        'limit': '5',
      },
    );
    return result.jsonArray.map((json) {
      return BrandModel.formJson(json);
    }).toList();
  }

  Future<List<BrandDetailsModel>> getBrandDetails(int id,
      {required int limit, required int offset}) async {
    final RequestResponse result = await apiClient.fetch(
        ApiPath.getBrandDetails + "/$id/products", RequestMethod.get,
        searchParams: {
          'limit': limit.toString(),
          'offset': offset.toString(),
        });
    print('limit : $limit offset :$offset');
    return result.jsonArray.map((json) {
      return BrandDetailsModel.formJson(json);
    }).toList();
  }

  final ApiClient apiClient = ApiClient();
}

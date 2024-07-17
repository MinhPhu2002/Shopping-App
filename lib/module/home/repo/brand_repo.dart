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
        'limit': '4',
      },
    );
    return result.jsonArray.map((json) {
      return BrandModel.formJson(json);
    }).toList();
  }

  final ApiClient apiClient = ApiClient();
}

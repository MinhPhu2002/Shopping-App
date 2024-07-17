import 'package:testapp/common/model/product_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';

class ProductsRepository {
  Future<List<ProductModel>> getProducts(int offset, int limit) async {
    final RequestResponse result = await apiClient.fetch(
      ApiPath.getProducts,
      RequestMethod.get,
      searchParams: {'limit': limit.toString(), 'offset': offset.toString()},
    );
    return result.jsonArray.map((json) {
      return ProductModel.formJson(json);
    }).toList();
  }

  Future<ProductDetailsModel> getProductDetails(int id) async {
    final RequestResponse result = await apiClient.fetch(
      ApiPath.getProductDetail + "$id",
      RequestMethod.get,
    );

    return ProductDetailsModel.formJson(result.json);
  }

  String removeCharacter(String text) {
    text = text.replaceAll('[', '');
    text = text.replaceAll(']', '');
    text = text.replaceAll('"', '');

    print(text);
    return text;
  }

  final ApiClient apiClient = ApiClient();
}

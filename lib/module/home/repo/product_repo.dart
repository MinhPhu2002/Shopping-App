import 'package:testapp/common/model/product_model.dart';
import 'package:testapp/core/constaints/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/request_method.dart';

class ProductsRepository {
  Future<List<ProductModel>> getProducts(int offset, int limit) async {
    final List result = await apiClient.fetch(
        searchParam: {'limit': limit.toString(), 'offset': offset.toString()},
        url: ApiPath.getProducts,
        method: RequestMethod.get);
    return result.map((item) {
      final json = item as Map<String, dynamic>;

      return ProductModel.formJson(json);
    }).toList();
  }

  Future<ProductDetailsModel> getProductDetails(int id) async {
    final Map result = await apiClient.fetch(
        url: ApiPath.getProductDetail + "$id", method: RequestMethod.get);
    return ProductDetailsModel.formJson(Map.castFrom(result));
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

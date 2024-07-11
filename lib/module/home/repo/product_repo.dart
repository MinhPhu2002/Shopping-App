import 'package:testapp/common/model/product_model.dart';
import 'package:testapp/core/constaints/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/request_method.dart';

class ProductsRepository {
  Future<List<ProductModel>> getProducts() async {
    final List result = await apiClient.fetch(
        url: ApiPath.getProducts, method: RequestMethod.get);
    return result.map((item) {
      final json = item as Map<String, dynamic>;

      return ProductModel(
        id: json['id'],
        title: json['title'],
        imageUrl: removeCharacter(json['images'][0]),
        price: json['price'].toString(),
      );
    }).toList();
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

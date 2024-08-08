import 'package:testapp/common/model/cart_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';
import 'package:testapp/data/services/auth_service.dart';

class CartRepository {
  Future<CartModel> getCart() async {
    int? id = AuthService.instance.userId;
    final RequestResponse result = await apiClient.fetch(
      ApiPath.getCart + '/$id',
      RequestMethod.get,
    );
    print(result.json);
    if (result.json['carts'].isEmpty) throw 'carts is empty';
    return CartModel.formJson(result.json['carts'][0]);
  }

  ApiClient apiClient = ApiClient();
}

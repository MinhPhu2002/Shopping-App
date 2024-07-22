import 'package:testapp/common/model/login_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';

class LoginRepository {
  Future<LoginModel> login(
      {required String email, required String password}) async {
    final RequestResponse result = await apiClient.fetch(
      ApiPath.login,
      RequestMethod.post,
      rawData: {
        'email': email,
        'password': password,
      },
    );
    return LoginModel.fromJson(result.json);
  }

  ApiClient apiClient = ApiClient();
}

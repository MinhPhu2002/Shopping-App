// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:testapp/common/model/user_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';
import 'package:testapp/data/services/auth_service.dart';

class UserRepository {
  Future<UserModel> getUser() async {
    final String path =
        AuthService.instance.ensureConfiguration(ApiPath.getUser);

    RequestResponse result = await apiClient.fetch(
      path,
      RequestMethod.get,
      token: AuthService.instance.accessToken,
    );

    AuthService.instance.saveUserInfo(result.json);
    return UserModel.formJson(result.json);
  }

  ApiClient apiClient = ApiClient();
}

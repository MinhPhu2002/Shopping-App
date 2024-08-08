import 'dart:convert';

import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';
import 'package:testapp/data/services/auth_service.dart';

class LoginRepository {
  Future<bool> login({required String email, required String password}) async {
    final RequestResponse result =
        await apiClient.fetch(ApiPath.login, RequestMethod.post,
            encodeData: jsonEncode({
              'username': email,
              'password': password,
            }));
    final String token = result.json['token'];
    final String refreshToken = result.json['token'];

    AuthService.instance
        .saveToken(accessToken: token, refreshToken: refreshToken);
    AuthService.instance.saveUserId(result.json['id']);

    return result.hasError == false;
  }

  ApiClient apiClient = ApiClient();
}

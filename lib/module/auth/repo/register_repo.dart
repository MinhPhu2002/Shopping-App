import 'dart:convert';

import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';
import 'package:testapp/data/services/auth_service.dart';

class RegisterRepo {
  Future<bool> checkUserNameExist({required String data}) async {
    final RequestResponse result = await apiClient.fetch(
        ApiPath.checkUsernameExist, RequestMethod.post,
        encodeData: jsonEncode({'username': data}));
    if (result.json['result'].toString().contains('true')) return true;
    return false;
  }

  Future<bool> checkEmailExist({required String data}) async {
    final RequestResponse result = await apiClient.fetch(
        ApiPath.checkEmailExist, RequestMethod.post,
        encodeData: jsonEncode({'email': data}));
    if (result.json['result'].toString().contains('true')) return true;
    return false;
  }

  Future<bool> register(
      {required String username,
      required String password,
      required String email}) async {
    final RequestResponse result =
        await apiClient.fetch(ApiPath.register, RequestMethod.post,
            encodeData: jsonEncode({
              'username': username,
              'password': password,
              'email': email,
              'expiresInMins': 1,
            }));
    final String token = result.json['token'];
    final String refreshToken = result.json['refreshToken'];

    AuthService.instance
        .saveToken(accessToken: token, refreshToken: refreshToken);
    return result.hasError == false;
  }

  ApiClient apiClient = ApiClient();
}

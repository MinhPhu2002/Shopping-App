import 'dart:convert';

import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';
import 'package:testapp/data/services/auth_service.dart';
import 'package:testapp/module/auth/repo/otp_vertification_repo.dart';

class VertifyForgotPasswordRepo extends OtpVertificationRepo {
  @override
  Future<bool> vertifyOtp(
      {required String username, required String otp}) async {
    final String path =
        AuthService.instance.ensureConfiguration(ApiPath.vertifyOtp);
    final RequestResponse result =
        await apiClient.fetch(path, RequestMethod.post,
            encodeData: jsonEncode({
              'username': username,
              'enteredOtp': otp,
              'expiresInMins': 1,
            }));

    // AuthService.instance.saveUserId(result.json['id'].toString());
    AuthService.instance.saveLoginType(loginTypeList.systemAccount);

    return result.hasError == false;
  }

  ApiClient apiClient = ApiClient();
}

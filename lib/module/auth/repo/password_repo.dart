import 'dart:convert';

import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';
import 'package:testapp/data/services/auth_service.dart';

class PasswordRepository {
  Future<bool> forgotpassword({required String username}) async {
    final String path =
        AuthService.instance.ensureConfiguration(ApiPath.forgotPassword);
    final RequestResponse result =
        await apiClient.fetch(path, RequestMethod.post,
            encodeData: jsonEncode({
              'username': username,
              'verification': '4 digit OTP',
            }));
    if (result.json['result'] == true) return true;
    return false;
  }

  Future<bool> vertifyOtp(
      {required String username, required String otp}) async {
    final String path =
        AuthService.instance.ensureConfiguration(ApiPath.vertifyOtp);
    final RequestResponse result =
        await apiClient.fetch(path, RequestMethod.post,
            encodeData: jsonEncode({
              'email': username,
              'enteredOtp': otp,
            }));
    if (result.json['result'] == true) return true;
    return false;
  }

  Future<bool> resetPassword(
      {required String username, required String password}) async {
    final String path =
        AuthService.instance.ensureConfiguration(ApiPath.resetPassword);
    final RequestResponse result =
        await apiClient.fetch(path, RequestMethod.post,
            encodeData: jsonEncode({
              'username': username,
              'password': password,
            }));
    if (result.json['result'] == true) return true;
    return false;
  }

  Future<bool> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final String path =
        AuthService.instance.ensureConfiguration(ApiPath.changePassword);
    final RequestResponse result = await apiClient.fetch(
        path, RequestMethod.post,
        token: AuthService.instance.accessToken,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        });
    if (result.json['result'] == true) return true;
    return false;
  }

  ApiClient apiClient = ApiClient();
}

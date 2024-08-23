import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testapp/common/model/user_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';
import 'package:testapp/data/services/auth_service.dart';

class UserRepository {
  Future<UserModel> getUser() async {
    RequestResponse result = await apiClient.fetch(
      ApiPath.getUser,
      RequestMethod.get,
      token: AuthService.instance.accessToken,
    );

    AuthService.instance.saveUserInfo(result.json);
    return UserModel.formJson(result.json);
  }

  ApiClient apiClient = ApiClient();
}

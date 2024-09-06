import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
              'expiresInMins': 1,
            }));
    final String token = result.json['token'];
    final String refreshToken = result.json['refreshToken'];

    AuthService.instance
        .saveToken(accessToken: token, refreshToken: refreshToken);
    AuthService.instance.saveUserId(result.json['id'].toString());
    AuthService.instance.saveLoginType(loginTypeList.systemAccount);

    return result.hasError == false;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuthen =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuthen.accessToken,
        idToken: googleAuthen.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print("token : ${credential.accessToken}");
      final RequestResponse result = await apiClient.fetch(
          ApiPath.loginGoogle, RequestMethod.post,
          rawData: ({
            'expiresInMins': 1,
            'token': await userCredential.user!.getIdToken()
          }));
      final String token = result.json['accessToken'];

      final String refreshToken = result.json['refreshToken'];

      AuthService.instance
          .saveToken(accessToken: token, refreshToken: refreshToken);
      AuthService.instance.saveUserId(result.json['id']);
      AuthService.instance.saveLoginType(loginTypeList.googleAccount);
      return result.hasError == false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ApiClient apiClient = ApiClient();
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:testapp/data/services/auth_service.dart';

class TestInterceptor extends InterceptorsWrapper {
  TestInterceptor() : authService = AuthService.instance;
  final AuthService authService;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest

    log(options.uri.toString(), name: 'Api called');
    log(options.method.toString(), name: 'method: ');
    log(options.headers.toString(), name: 'header');
    log(options.data.toString(), name: 'data: ');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    log(response.data.toString(), name: 'data');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(err.message.toString(), name: 'Error');
    // TODO: implement onError
    super.onError(err, handler);
  }
}

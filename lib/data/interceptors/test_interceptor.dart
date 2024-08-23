import 'package:dio/dio.dart';
import 'package:testapp/data/services/auth_service.dart';

class TestInterceptor extends InterceptorsWrapper {
  TestInterceptor() : authService = AuthService.instance;
  final AuthService authService;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    print('Api called : ${options.uri}');
    print(options.method);
    print(options.headers);
    super.onRequest(options, handler);
  }
}

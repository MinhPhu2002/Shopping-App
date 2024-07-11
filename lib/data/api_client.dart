import 'package:dio/dio.dart';
import 'package:testapp/core/constaints/api_path.dart';

class ApiClient {
  final Dio dio;

  ApiClient() : dio = Dio(BaseOptions(baseUrl: ApiPath.baseUrl));
  Future<dynamic> fetch({
    required String url,
    required String method,
    Map<String, String>? searchParam,
  }) async {
    try {
      final response = await dio.request(
        url,
        options: Options(method: method),
        queryParameters: searchParam,
      );
      if (response.statusCode != 200) {
        throw response.statusMessage ?? '';
      }
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}

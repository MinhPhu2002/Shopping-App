import 'package:testapp/common/model/comment_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';

class CommentRepository {
  Future<List<CommentModel>> getComment(
      {required int limit, required int skip}) async {
    final RequestResponse result = await apiClient.fetch(
      ApiPath.getComment,
      RequestMethod.get,
      searchParams: {'limit': limit.toString(), 'skip': skip.toString()},
    );

    print('limit : $limit skip:$skip');
    final List comment = result.json["comments"];
    return comment.map((json) {
      return CommentModel.formJson(json);
    }).toList();
  }

  final ApiClient apiClient = ApiClient();
}

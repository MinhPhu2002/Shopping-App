import 'dart:convert';

import 'package:testapp/common/model/comment_model.dart';
import 'package:testapp/core/constants/api_path.dart';
import 'package:testapp/data/api_client.dart';
import 'package:testapp/data/models/request_method.dart';
import 'package:testapp/data/models/request_response.dart';

class AddCommentRepository {
  Future<AddCommentModel> addComment(
      {required String body, required int postId, required int userId}) async {
    final RequestResponse result = await apiClient.fetch(
      ApiPath.addComment,
      RequestMethod.post,
      headers: {'Content-Type': 'application/json'},
      rawData: {
        'body': body,
        'postId': postId,
        'userId': userId,
      },
    );

    return AddCommentModel.formJson(result.json);
  }

  ApiClient apiClient = ApiClient();
}

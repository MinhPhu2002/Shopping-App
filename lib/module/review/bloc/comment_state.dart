import 'package:testapp/common/model/comment_model.dart';

class CommentState {
  final List<CommentModel>? comment;
  final String? errorMessage;
  final bool isLoading;

  CommentState({
    this.comment,
    this.errorMessage,
    required this.isLoading,
  });
}

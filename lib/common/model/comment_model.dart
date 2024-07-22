class CommentModel {
  final int id;
  final String comment;
  final String user;
  factory CommentModel.formJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      comment: json['body'],
      user: json['user']['fullName'],
    );
  }

  CommentModel({
    required this.id,
    required this.comment,
    required this.user,
  });
}

class AddCommentModel {
  final String body;
  final int postId;
  final int userId;

  AddCommentModel(
      {required this.body, required this.postId, required this.userId});
  factory AddCommentModel.formJson(Map<String, dynamic> json) {
    return AddCommentModel(
        body: json['body'], postId: json['postId'], userId: json['user']['id']);
  }
}

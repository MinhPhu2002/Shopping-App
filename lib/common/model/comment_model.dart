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

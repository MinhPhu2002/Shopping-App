class CommentModel {
  final int rating;
  final String comment;
  final String user;
  final String date;
  factory CommentModel.formJson(Map<String, dynamic> json) {
    return CommentModel(
      rating: json['rating'],
      comment: json['comment'],
      user: json['reviewerName'],
      date: json['date'],
    );
  }

  CommentModel({
    required this.rating,
    required this.comment,
    required this.user,
    required this.date,
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

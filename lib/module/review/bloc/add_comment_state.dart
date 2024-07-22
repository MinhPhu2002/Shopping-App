import 'package:testapp/common/model/comment_model.dart';

class AddCommentState {}

class AddCommentInitialState extends AddCommentState {}

class AddCommentLoadingInProgress extends AddCommentState {}

class AddCommentSuccess extends AddCommentState {
  final AddCommentModel addCommentModel;

  AddCommentSuccess({required this.addCommentModel});
}

class AddCommentLoadingError extends AddCommentState {
  final String errorMessage;

  AddCommentLoadingError({required this.errorMessage});
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/review/bloc/add_comment_state.dart';
import 'package:testapp/module/review/repo/add_comment_repo.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit() : super(AddCommentInitialState());
  final AddCommentRepository repo = AddCommentRepository();
  Future<void> addComment(String body, int postId, int userId) async {
    try {
      emit(AddCommentInitialState());
      emit(AddCommentLoadingInProgress());
      final result = await repo.addComment(
        body: body,
        postId: postId,
        userId: userId,
      );
      emit(AddCommentSuccess(addCommentModel: result));
    } catch (e) {
      emit(AddCommentLoadingError(errorMessage: e.toString()));
    }
  }
}

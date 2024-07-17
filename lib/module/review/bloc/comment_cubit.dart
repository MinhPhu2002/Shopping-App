import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/review/bloc/comment_state.dart';
import 'package:testapp/module/review/repo/comment_repo.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentState(isLoading: true)) {
    load();
  }
  final CommentRepository repo = CommentRepository();
  int skip = 0;
  Future<void> load() async {
    try {
      emit(CommentState(isLoading: true));
      final result = await repo.getComment(limit: 10, skip: skip);

      emit(CommentState(isLoading: false, comment: result));
    } catch (e) {
      emit(CommentState(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> loadMore() async {
    skip = skip + 10;
    try {
      emit(CommentState(comment: state.comment, isLoading: true));
      final result = await repo.getComment(limit: 10, skip: skip);

      emit(CommentState(
          isLoading: false, comment: [...?state.comment, ...result]));
    } catch (e) {
      emit(
        CommentState(
          isLoading: false,
          errorMessage: e.toString(),
          comment: state.comment,
        ),
      );
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/home/bloc/user/user_state.dart';
import 'package:testapp/module/home/repo/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoadingInProgress()) {
    load();
  }
  final UserRepository repo = UserRepository();
  Future<void> load() async {
    try {
      emit(UserLoadingInProgress());
      final result = await repo.getUser();
      emit(UserLoaded(user: result));
    } catch (e) {
      emit(UserLoadingError(errorMessage: e.toString()));
    }
  }
}

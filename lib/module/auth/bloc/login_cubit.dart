import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testapp/module/auth/bloc/login_state.dart';
import 'package:testapp/module/auth/repo/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  final LoginRepository repo = LoginRepository();
  Future<void> login(String email, String password) async {
    try {
      emit(LoginInitialState());
      emit(LoginLoadingInProgress());
      final result = await repo.login(email: email, password: password);
      if (result == true) {
        emit(LoginSuccess());
      } else
        emit(LoginFailed());
    } catch (e) {
      emit(LoginLoadingError(errorMessage: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(LoginInitialState());
      emit(LoginLoadingInProgress());
      final result = await repo.googleSignIn;
      if (result == true) {
        emit(LoginSuccess());
      } else
        emit(LoginFailed());
    } catch (e) {
      emit(LoginLoadingError(errorMessage: e.toString()));
    }
  }
}

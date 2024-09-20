import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/auth/bloc/password_state.dart';
import 'package:testapp/module/auth/repo/password_repo.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitialState());
  final PasswordRepository repo = PasswordRepository();
  Future<void> forgotpassword({required String username}) async {
    try {
      emit(PasswordInitialState());
      emit(PasswordLoadingInProgress());
      final result = await repo.forgotpassword(username: username);
      if (result == true) {
        emit(ForgotPassWordSuccess());
      } else {
        emit(ForgotPasswordFailed());
      }
    } catch (e) {
      emit(ForgotPasswordLoadingError(error: e.toString()));
    }
  }

  Future<void> vertifyOtp(
      {required String username, required String otp}) async {
    try {
      emit(VertifyInitialState());
      emit(VertifyLoadingInProgress());
      final result = await repo.vertifyOtp(username: username, otp: otp);
      if (result == true) {
        emit(VertifySuccess());
      } else {
        emit(VertifyFailed());
      }
    } catch (e) {
      emit(VertifyLoadingError(errorMessage: e.toString()));
    }
  }

  Future<void> resetPassword(
      {required String username, required String password}) async {
    try {
      emit(PasswordInitialState());
      emit(PasswordLoadingInProgress());
      final result =
          await repo.resetPassword(username: username, password: password);
      if (result) {
        emit(ResetPassWordSuccess());
      } else {
        emit(ResetPasswordFailed());
      }
    } catch (e) {
      emit(ResetPasswordLoadingError(error: e.toString()));
    }
  }

  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      emit(PasswordInitialState());
      emit(PasswordLoadingInProgress());
      final result = await repo.changePassword(
          oldPassword: oldPassword, newPassword: newPassword);
      if (result) {
        emit(ChangePassWordSuccess());
      } else {
        emit(ChangePasswordFailed());
      }
    } catch (e) {
      emit(ChangePasswordLoadingError(error: e.toString()));
    }
  }
}

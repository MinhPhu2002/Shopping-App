import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/auth/bloc/register_state.dart';
import 'package:testapp/module/auth/repo/register_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  final RegisterRepo repo = RegisterRepo();
  Future<void> register(String username, String password, String email) async {
    try {
      emit(RegisterInitialState());
      emit(RegisterLoadingInProgress());
      final result = await repo.register(
          username: username, password: password, email: email);
      if (result == true) {
        emit(RegisterSuccess());
      } else
        emit(RegisterFailed());
    } catch (e) {
      emit(RegisterLoadingError(errorMessage: e.toString()));
    }
  }

  Future<bool> checkUsernNameExist(String? data) async {
    if (data == null || data.isEmpty) return false;
    try {
      final result = await repo.checkUserNameExist(data: data);
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkEmailExist(String? data) async {
    if (data == null || data.isEmpty) return false;
    try {
      final result = await repo.checkEmailExist(data: data);
      return result;
    } catch (e) {
      return false;
    }
  }
}

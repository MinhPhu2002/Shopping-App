import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/module/auth/bloc/vertify_state.dart';
import 'package:testapp/module/auth/repo/otp_vertification_repo.dart';

class VertifyCubit extends Cubit<VertifyState> {
  VertifyCubit({required this.repo}) : super(VertifyInitialState());
  final OtpVertificationRepo repo;
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
}

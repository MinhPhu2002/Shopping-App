import 'package:testapp/common/model/user_model.dart';

class UserState {}

class UserLoadingInProgress extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded({required this.user});
}

class UserLoadingError extends UserState {
  final String errorMessage;

  UserLoadingError({required this.errorMessage});
}

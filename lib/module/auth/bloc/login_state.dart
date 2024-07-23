class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {}

class LoginLoadingError extends LoginState {
  final String errorMessage;

  LoginLoadingError({required this.errorMessage});
}

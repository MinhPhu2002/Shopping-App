import 'package:testapp/common/model/login_model.dart';

class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});
}

class LoginLoadingError extends LoginState {
  final String errorMessage;

  LoginLoadingError({required this.errorMessage});
}

class PasswordState {}

class PasswordInitialState extends PasswordState {}

class PasswordLoadingInProgress extends PasswordState {}

class ForgotPassWordSuccess extends PasswordState {}

class ForgotPasswordFailed extends PasswordState {}

class ForgotPasswordLoadingError extends PasswordState {
  final String error;

  ForgotPasswordLoadingError({required this.error});
}

class VertifyInitialState extends PasswordState {}

class VertifyLoadingInProgress extends PasswordState {}

class VertifySuccess extends PasswordState {}

class VertifyFailed extends PasswordState {}

class VertifyLoadingError extends PasswordState {
  final String errorMessage;

  VertifyLoadingError({required this.errorMessage});
}

class ResetPassWordSuccess extends PasswordState {}

class ResetPasswordFailed extends PasswordState {}

class ResetPasswordLoadingError extends PasswordState {
  final String error;

  ResetPasswordLoadingError({required this.error});
}

class ChangePassWordSuccess extends PasswordState {}

class ChangePasswordFailed extends PasswordState {}

class ChangePasswordLoadingError extends PasswordState {
  final String error;

  ChangePasswordLoadingError({required this.error});
}

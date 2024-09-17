class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingInProgress extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {}

class RegisterLoadingError extends RegisterState {
  final String errorMessage;

  RegisterLoadingError({required this.errorMessage});
}

class CheckExistAccess extends RegisterState {}

class CheckExistFailed extends RegisterState {}

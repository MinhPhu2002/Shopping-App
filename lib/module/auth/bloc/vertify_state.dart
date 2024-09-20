class VertifyState {}

class VertifyInitialState extends VertifyState {}

class VertifyLoadingInProgress extends VertifyState {}

class VertifySuccess extends VertifyState {}

class VertifyFailed extends VertifyState {}

class VertifyLoadingError extends VertifyState {
  final String errorMessage;

  VertifyLoadingError({required this.errorMessage});
}

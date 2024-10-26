part of 'bloc.dart';

class GenerStates {}

class LoadingState extends GenerStates {}

class SuccessState extends GenerStates {
  final List<GenerModel> model;

  SuccessState(this.model);
}

class FailState extends GenerStates {
  final String msg;

  FailState({required this.msg});
}

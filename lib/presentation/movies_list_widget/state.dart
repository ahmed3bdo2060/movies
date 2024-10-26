

import '../../data/dtos/model.dart';

class MoviesListState {}

class LoadingState extends MoviesListState {}

class SuccessState extends MoviesListState {
  final List<MovieModel> movies;

  SuccessState(this.movies);
}

class FailState extends MoviesListState {
  final String msg;

  FailState({required this.msg});
}

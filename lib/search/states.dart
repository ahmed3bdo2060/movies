import '../data/dtos/model.dart';

class SearchStates{}
class LoadingSearchState extends SearchStates{}
class SuccessSearchState extends SearchStates{
  final List<MovieModel> movies;

  SuccessSearchState(this.movies);
}
class FailedSearchState extends SearchStates{
  final String msg;

  FailedSearchState({required this.msg});
}
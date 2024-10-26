import 'package:app/data/dtos/model.dart';

class SearchEvents{}
class SearchEvent extends SearchEvents{}
class DeleteSearchEvent extends SearchEvents{
  final String word;
  final List<MovieModel> list;

  DeleteSearchEvent({required this.word, required this.list});
}
class SearchEventUpdate extends SearchEvents{
  final String word;

  SearchEventUpdate({required this.word});
}
class FetchSearchResults extends SearchEvents{}
class FetchMoreSearchResults extends SearchEvents{}



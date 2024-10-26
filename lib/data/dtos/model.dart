
class MoviesResultModel {
  late final int page;
  late final List<MovieModel> list;
  late final int totalPages;
  late final int totalResults;

  MoviesResultModel.fromJson(Map<String, dynamic> json){
    page = json['page'];
    list = List.from(json['results']).map((e)=>MovieModel.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class MovieModel {
  late final bool adult;
  late final String backdropPath;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final double voteAverage;
  late final int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json){
    adult = json['adult']??false;
    backdropPath = json['backdrop_path']??"";
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']??[]);
    id = json['id']??0;
    originalLanguage = json['original_language']??"";
    originalTitle = json['original_title']??"";
    overview = json['overview']??"";
    popularity = json['popularity']??0.0;
    posterPath = json['poster_path']??"";
    releaseDate = json['release_date']??"";
    title = json['title']??"";
    video = json['video']??true;
    voteAverage = json['vote_average']??0.0;
    voteCount = json['vote_count']??0;
  }
}
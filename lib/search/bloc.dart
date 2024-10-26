import 'dart:async';

import 'package:app/data/dtos/model.dart';
import 'package:app/search/events.dart';
import 'package:app/search/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/core/logic/dio_helper.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  final controller = TextEditingController();
  final DioHelper _dio;
  List<MovieModel> list = [];
  int page = 1;

  SearchBloc(this._dio) : super(LoadingSearchState()) {
    on<SearchEvent>(getData);
    on<SearchEventUpdate>(update);
    on<DeleteSearchEvent>(delete);
  }

  Future<void> getData(SearchEvent event, Emitter<SearchStates> emit) async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3//search/movie?api_key=ff6627b2838427c934ed8ab6d6a0a17f&query=${controller.text}");
    if (response.isSuccess) {
     final model = MoviesResultModel
          .fromJson(response.data)
          .list;
      emit(SuccessSearchState(model));
    } else {
      emit(FailedSearchState(msg: response.msg!));
    }
  }


  Future<void> update(SearchEventUpdate event, Emitter<SearchStates> emit) async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3//search/movie?api_key=ff6627b2838427c934ed8ab6d6a0a17f&query=${controller.text}");
    final model2 = MoviesResultModel.fromJson(response.data).list;
      if (controller.text.isEmpty) {
        list = model2;
      } else {
         list = model2.where((element) => element.title.toLowerCase().contains(controller.text.toLowerCase())).toList();
      }
      emit(SuccessSearchState(list));
    }

  Future<void> delete(DeleteSearchEvent event, Emitter<SearchStates> emit)async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3//search/movie?api_key=ff6627b2838427c934ed8ab6d6a0a17f&query=${controller.text}");
    final model = MoviesResultModel.fromJson(response.data).list;
    list = model;
    list.clear();
    controller.clear();
    emit(SuccessSearchState(list));
  }


}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:app/search/events.dart';
// import 'package:app/search/states.dart';
// import '../presentation/core/logic/dio_helper.dart';
// import 'package:app/data/dtos/model.dart';
//
// class SearchBloc extends Bloc<SearchEvents, SearchStates> {
//   final TextEditingController controller = TextEditingController();
//   final DioHelper _dio;
//   List<MovieModel> list = [];
//   int page = 1; // Initial page number
//   int totalPages = 1; // Total pages available
//
//   SearchBloc(this._dio) : super(LoadingSearchState());
//
//   @override
//   Stream<SearchStates> mapEventToState(SearchEvent event) async* {
//     if (event is FetchSearchResults) {
//       yield* _mapFetchSearchResultsToState(event as FetchSearchResults);
//     } else if (event is FetchMoreSearchResults) {
//       yield* _mapFetchMoreSearchResultsToState(event as FetchMoreSearchResults);
//     }
//   }
//
//   Stream<SearchStates> _mapFetchSearchResultsToState(FetchSearchResults event) async* {
//     try {
//       // Reset page to 1 when initiating a new search
//       page = 1;
//
//       final response = await _fetchSearchResults(page);
//
//       if (response.isSuccess) {
//         list = MoviesResultModel.fromJson(response.data).list;
//         totalPages = MoviesResultModel.fromJson(response.data).totalPages;
//         yield SuccessSearchState(list);
//       } else {
//         yield FailedSearchState(msg: response.msg!);
//       }
//     } catch (e) {
//       yield FailedSearchState(msg: 'Failed to fetch data. Please try again later.');
//     }
//   }
//
//   Stream<SearchStates> _mapFetchMoreSearchResultsToState(FetchMoreSearchResults event) async* {
//     try {
//       // Check if there are more pages to fetch
//       if (page < totalPages) {
//         page++;
//         final response = await _fetchSearchResults(page);
//
//         if (response.isSuccess) {
//           final newList = MoviesResultModel.fromJson(response.data).list;
//           list.addAll(newList);
//           yield SuccessSearchState(list);
//         } else {
//           yield FailedSearchState(msg: response.msg!);
//         }
//       }
//     } catch (e) {
//       yield FailedSearchState(msg: 'Failed to fetch more data. Please try again later.');
//     }
//   }
//
//   Future<CustomResponse> _fetchSearchResults(int page) async {
//     final response = await _dio.get(
//       "https://api.themoviedb.org/3/search/movie?api_key=ff6627b2838427c934ed8ab6d6a0a17f&query=${controller.text}&page=$page",
//     );
//     return response;
//   }
// }

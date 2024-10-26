
import 'dart:async';

import 'package:app/presentation/movies_list_widget/events.dart';
import 'package:app/presentation/movies_list_widget/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dtos/model.dart';
import '../all/view_config.dart';
import '../core/logic/dio_helper.dart';


// class MoviesListBloc extends Bloc<MoviesListEvent,MoviesListState>{
//   final DioHelper _dio;
//   final ViewConfig config;
//   int page = 0;
//   List<MovieModel> list=[];
//   MoviesListBloc(this._dio, this.config):super(LoadingState()){
//     on<FetchData>(getData);
//     on<FetchDataLoadMore>(loadMore);
//
//     page = config.initialPage;
//   }
//
//   Future<void> getData(FetchData event, Emitter<MoviesListState> emit) async {
//     String? gener =
//         config is GenerViewConfig ? (config as GenerViewConfig).generId : null;
//     page = config.initialPage;
//     final response = await _dio.get(
//         "https://api.themoviedb.org/3/${config.action}?include_adult=false&include_video=${config.includeVideo}&language=${config.language}&page=$page&sort_by=${config.sort}&with_genres=$gener");
//     if (response.isSuccess) {
//       final model = MoviesResultModel.fromJson(response.data).list;
//       list=model;
//       emit(SuccessState(list));
//     } else {
//       emit(FailState(msg: response.msg!));
//     }
//   }
//   Future<void> loadMore(FetchDataLoadMore event, Emitter<MoviesListState> emit) async {
//     String? gener =
//     config is GenerViewConfig ? (config as GenerViewConfig).generId : null;
//     if (config.hasLoadMore) {
//       page++;
//     }
//     final response = await _dio.get(
//         "https://api.themoviedb.org/3/${config.action}?include_adult=false&include_video=${config.includeVideo}&language=${config.language}&page=$page&sort_by=${config.sort}&with_genres=$gener");
//     if (response.isSuccess) {
//       final model = MoviesResultModel.fromJson(response.data).list;
//       list.addAll(model);
//       emit(SuccessState(list));
//     } else {
//       emit(FailState(msg: response.msg!));
//     }
//   }
// }

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final DioHelper _dio;
  final ViewConfig config;
  int page = 0;
  List<MovieModel> list = [];

  MoviesListBloc(this._dio, this.config) : super(LoadingState()) {
    on<FetchData>(getData);
    on<FetchDataLoadMore>(loadMore);

    page = config.initialPage;
  }

  Future<void> getData(FetchData event, Emitter<MoviesListState> emit) async {
    await _fetchData(event, emit, reset: true);
  }

  Future<void> loadMore(
      FetchDataLoadMore event, Emitter<MoviesListState> emit) async {
    if (config.hasLoadMore) {
      page++;
      await _fetchData(event, emit, reset: false);
    }
  }

  Future<void> _fetchData(
      MoviesListEvent event, Emitter<MoviesListState> emit, {bool reset = true}) async {
    String? gener =
    config is GenerViewConfig ? (config as GenerViewConfig).generId : null;
    final response = await _dio.get(
        "https://api.themoviedb.org/3/${config.action}?include_adult=false&include_video=${config.includeVideo}&language=${config.language}&page=$page&sort_by=${config.sort}&with_genres=$gener");
    if (response.isSuccess) {
      final model = MoviesResultModel.fromJson(response.data).list;
      if (reset) {
        list = model;
      } else {
        list.addAll(model);
      }
      emit(SuccessState(list)); // Emit a copy of the list to ensure immutability
    } else {
      emit(FailState(msg: response.msg ?? 'Unknown error'));
    }
  }
}
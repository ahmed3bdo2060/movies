import 'package:app/presentation/core/logic/dio_helper.dart';
import 'package:app/search/bloc.dart';
import 'package:app/search/events.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'presentation/all/bloc.dart';

void initServiceLocator() {
  final container = GetIt.instance;
  container.registerSingleton(DioHelper());

  container
      .registerFactory(() => GenerBloc(container<DioHelper>())..add(FetchData()));
      container.registerFactory(() => SearchBloc(container<DioHelper>())..add(SearchEvent()));
}

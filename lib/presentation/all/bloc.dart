
import 'dart:async';

import 'package:app/data/dtos/gener_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dtos/model.dart';
import '../core/logic/dio_helper.dart';
part 'state.dart';
part 'events.dart';
class GenerBloc extends Bloc<AllEvents,GenerStates>{
  final DioHelper _dio;
  GenerBloc(this._dio):super(LoadingState()){
    on<FetchData>(getData);
  }

  Future<void> getData(FetchData event, Emitter<GenerStates> emit)async {
    final response = await _dio.get("https://api.themoviedb.org/3/genre/movie/list?language=en");
    if(response.isSuccess){
final model = GenerData.fromJson(response.data).list;
emit(SuccessState(model));
    }else{
      emit(
        FailState(msg: response.msg!)
      );
    }
  }
}
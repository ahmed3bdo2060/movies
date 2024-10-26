import 'package:dio/dio.dart';
import 'cash_helper.dart';

class NetworkException implements Exception{}
class LoginException implements Exception{
  final String message;

  LoginException(this.message);
}
class DioHelper{
   final _dio = Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3/discover/",
       headers: {
     "Accept":"application/json",
     "Authorization":"Bearer ${CashHelper.token}",
   }));
 Future<CustomResponse> get(String path,
       {Map<String, dynamic>? queryParameters}) async {
     try {
       final response = await _dio.get(
         path,
         queryParameters: queryParameters,
       );
       print(response.data);
       return CustomResponse(
         isSuccess: true,
         data: response.data,
         msg: response.data["message"],
       );
     } on DioException catch (ex) {
       return _handleException(ex);
     }
   }

  //  Future<CustomResponse> get (String path)async {
  //   try {
  //     final response = await _dio.get(path);
  //     return CustomResponse(isSuccess:true,data: response.data);
  //   }
  //   on DioException catch(ex){
  //     return _handleException(ex);
  //   }
  // }

   Future <CustomResponse> send(String path,{Map<String,dynamic>? data})async {
    try {
      final response = await _dio.post(path,data: data);
      return CustomResponse(isSuccess:true,data: response.data,msg: response.data["message"]);
    }
    on DioException catch(ex){
      return _handleException(ex);
    }
  }
  CustomResponse _handleException(DioException ex) {
     print(ex.error);
     print(ex.response?.data);
     print(ex.message);
     print(ex.type);
     print(ex.stackTrace);
     return CustomResponse(
       isSuccess: false,
       msg: ex.response?.data["message"],
     );
   }
  //  CustomResponse handleExeption(DioException ex){
  //   print(ex.response?.data);
  //   String? msg = ex.response?.data["message"];
  //   return CustomResponse(isSuccess: false,message: msg ?? ex.type.name);
  //
  // }
}
class CustomResponse {
  final bool isSuccess;
  final data;
  final String? msg;

  CustomResponse({required this.isSuccess, this.data, this.msg});
}
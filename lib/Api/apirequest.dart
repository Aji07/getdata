import 'package:dio/dio.dart';
import 'package:getdata/Model/data.dart';
import 'package:retrofit/http.dart';
part 'apirequest.g.dart';
@RestApi(baseUrl: "https://gorest.co.in/public-api/")
abstract class ApiRequest{
  factory ApiRequest(
      Dio dio,{required String baseUrl})=_ApiRequest;
  @GET('/users')
  Future<ResponseData>getUsers();
}
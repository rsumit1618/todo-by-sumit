import 'package:data/models/base/base_request_model.dart';
import 'package:data/models/base/base_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

//@generate --> dart run build_runner build --delete-conflicting-outputs
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST("/Account/DummyApi")
  Future<HttpResponse<BaseResponseModel>> fetchAccounts(@Body() BaseRequestModel fetchAccountRequestEntity);

  @GET("/todos")
  Future<HttpResponse<BaseResponseModel>> getTodos();

  @POST("/todos")
  Future<HttpResponse<BaseResponseModel>> createTodo(@Body() BaseRequestModel request);

  @PUT("/todos/{id}")
  Future<HttpResponse<BaseResponseModel>> updateTodo(
    @Path("id") String id,
    @Body() BaseRequestModel request,
  );

  @DELETE("/todos/{id}")
  Future<HttpResponse<BaseResponseModel>> deleteTodo(@Path("id") String id);
}

import 'package:data/models/base/base_request_model.dart';
import 'package:data/models/base/base_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

// After adding or changing Retrofit APIs, run:
// dart run build_runner build --delete-conflicting-outputs
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  // ---------------------------------------------------------------------------
  // KickStack starter APIs
  //
  // Keep these as copy-paste examples when creating a new feature API.
  // Replace request/response models with feature-specific DTOs as the app grows.
  // ---------------------------------------------------------------------------

  @GET("/api/v1/profile")
  Future<HttpResponse<BaseResponseModel>> getProfile();

  @GET("/api/v1/catalog/products")
  Future<HttpResponse<BaseResponseModel>> getProducts({
    @Query("page") int page = 1,
    @Query("limit") int limit = 20,
    @Header("X-Feature") String feature = "starter",
  });

  @POST("/api/v1/auth/login")
  Future<HttpResponse<BaseResponseModel>> login(
    @Body() BaseRequestModel request,
  );

  @PUT("/api/v1/profile/{id}")
  Future<HttpResponse<BaseResponseModel>> updateProfile(
    @Path("id") String id,
    @Body() BaseRequestModel request,
  );

  @DELETE("/api/v1/auth/sessions/{id}")
  Future<HttpResponse<BaseResponseModel>> deleteSession(
    @Path("id") String id,
  );

  // First UI example. The starter screen calls this through use case flow.
  @POST("/api/v1/dashboard/summary")
  Future<HttpResponse<BaseResponseModel>> getDashboardSummary(
    @Body() BaseRequestModel request,
  );

  @GET("/api/v1/live-updates")
  Future<HttpResponse<BaseResponseModel>> getLiveUpdates();

  // ---------------------------------------------------------------------------
  // Task network examples
  // ---------------------------------------------------------------------------

  @GET("/api/v1/tasks")
  Future<HttpResponse<BaseResponseModel>> getTasks();

  @POST("/api/v1/tasks")
  Future<HttpResponse<BaseResponseModel>> createTask(
    @Body() BaseRequestModel request,
  );

  @PUT("/api/v1/tasks/{id}")
  Future<HttpResponse<BaseResponseModel>> updateTask(
    @Path("id") String id,
    @Body() BaseRequestModel request,
  );

  @DELETE("/api/v1/tasks/{id}")
  Future<HttpResponse<BaseResponseModel>> deleteTask(@Path("id") String id);
}

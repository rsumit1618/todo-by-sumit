import 'package:data/models/base/base_response_model.dart';
import 'package:retrofit/dio.dart';

abstract class UserRepositoryDs {
  Future<HttpResponse<BaseResponseModel>> getUserNameFromLocalNetwork();
  Future<HttpResponse<BaseResponseModel>> getUserNameFromStorage();
  Future<HttpResponse<BaseResponseModel>> getUserNameFromLocalDB();
}
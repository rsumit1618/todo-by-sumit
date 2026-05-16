import 'package:data/models/base/base_response_model.dart';
import 'package:retrofit/dio.dart';

abstract class LiveUpdateRemoteDataSource {
  Future<HttpResponse<BaseResponseModel>> getInitialLiveUpdates();
}

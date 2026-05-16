import 'package:data/models/base/base_response_model.dart';
import 'package:data/remote/api_service.dart';
import 'package:data/source/live_update/network/live_update_remote_data_source.dart';
import 'package:retrofit/dio.dart';

class LiveUpdateRemoteDataSourceImpl extends LiveUpdateRemoteDataSource {
  final ApiService _apiService;

  LiveUpdateRemoteDataSourceImpl(this._apiService);

  @override
  Future<HttpResponse<BaseResponseModel>> getInitialLiveUpdates() {
    return _apiService.getLiveUpdates();
  }
}

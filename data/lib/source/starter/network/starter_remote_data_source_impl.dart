import 'package:data/models/base/base_request_model.dart';
import 'package:data/models/base/base_response_model.dart';
import 'package:data/remote/api_service.dart';
import 'package:data/source/starter/network/starter_remote_data_source.dart';
import 'package:retrofit/dio.dart';

class StarterRemoteDataSourceImpl extends StarterRemoteDataSource {
  final ApiService _apiService;

  StarterRemoteDataSourceImpl(this._apiService);

  @override
  Future<HttpResponse<BaseResponseModel>> getDashboardSummary() async {
    return _apiService.getDashboardSummary(
      BaseRequestModel(
        baseData: {
          "customerId": "starter-customer-001",
          "includeInactive": false,
        },
      ),
    );
  }
}

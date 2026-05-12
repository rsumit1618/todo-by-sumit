import 'package:data/models/base/base_request_model.dart';
import 'package:data/models/base/base_response_model.dart';
import 'package:data/remote/api_service.dart';
import 'package:data/source/user/network/user_repository_ds.dart';
import 'package:retrofit/dio.dart';

class UserRepositoryDsImpl extends UserRepositoryDs{

  final ApiService _apiService;

  UserRepositoryDsImpl(this._apiService);

  @override
  Future<HttpResponse<BaseResponseModel>> getUserNameFromLocalDB() async {
    return _apiService.fetchAccounts(BaseRequestModel(baseData: {}));
  }

  @override
  Future<HttpResponse<BaseResponseModel>> getUserNameFromLocalNetwork() {
    // TODO: implement getUserNameFromLocalNetwork
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<BaseResponseModel>> getUserNameFromStorage() {
    // TODO: implement getUserNameFromStorage
    throw UnimplementedError();
  }

}
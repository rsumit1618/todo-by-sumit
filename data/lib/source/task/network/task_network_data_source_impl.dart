import 'package:data/models/base/base_request_model.dart';
import 'package:data/models/base/base_response_model.dart';
import 'package:data/models/remote/task/task_dto.dart';
import 'package:data/remote/api_service.dart';
import 'package:data/source/task/network/task_network_data_source.dart';
import 'package:retrofit/dio.dart';

class TaskNetworkDataSourceImpl extends TaskNetworkDataSource {
  final ApiService _apiService;

  TaskNetworkDataSourceImpl(this._apiService);

  @override
  Future<HttpResponse<BaseResponseModel>> getTasks() {
    return _apiService.getTasks();
  }

  @override
  Future<HttpResponse<BaseResponseModel>> createTask(TaskDto task) {
    return _apiService.createTask(BaseRequestModel(baseData: task.toJson()));
  }

  @override
  Future<HttpResponse<BaseResponseModel>> updateTask(TaskDto task) {
    return _apiService.updateTask(
      task.id,
      BaseRequestModel(baseData: task.toJson()),
    );
  }

  @override
  Future<HttpResponse<BaseResponseModel>> deleteTask(String id) {
    return _apiService.deleteTask(id);
  }
}

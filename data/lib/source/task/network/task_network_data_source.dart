import 'package:data/models/base/base_response_model.dart';
import 'package:data/models/remote/task/task_dto.dart';
import 'package:retrofit/dio.dart';

abstract class TaskNetworkDataSource {
  Future<HttpResponse<BaseResponseModel>> getTasks();

  Future<HttpResponse<BaseResponseModel>> createTask(TaskDto task);

  Future<HttpResponse<BaseResponseModel>> updateTask(TaskDto task);

  Future<HttpResponse<BaseResponseModel>> deleteTask(String id);
}

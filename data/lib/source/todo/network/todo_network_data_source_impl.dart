import 'package:data/models/base/base_request_model.dart';
import 'package:data/models/base/base_response_model.dart';
import 'package:data/models/remote/todo/todo_dto.dart';
import 'package:data/remote/api_service.dart';
import 'package:data/source/todo/network/todo_network_data_source.dart';
import 'package:retrofit/dio.dart';

class TodoNetworkDataSourceImpl extends TodoNetworkDataSource {
  final ApiService _apiService;

  TodoNetworkDataSourceImpl(this._apiService);

  @override
  Future<HttpResponse<BaseResponseModel>> getTodos() {
    return _apiService.getTodos();
  }

  @override
  Future<HttpResponse<BaseResponseModel>> createTodo(TodoDto todo) {
    return _apiService.createTodo(
      BaseRequestModel(baseData: todo.toJson()),
    );
  }

  @override
  Future<HttpResponse<BaseResponseModel>> updateTodo(TodoDto todo) {
    return _apiService.updateTodo(
      todo.id,
      BaseRequestModel(baseData: todo.toJson()),
    );
  }

  @override
  Future<HttpResponse<BaseResponseModel>> deleteTodo(String id) {
    return _apiService.deleteTodo(id);
  }
}

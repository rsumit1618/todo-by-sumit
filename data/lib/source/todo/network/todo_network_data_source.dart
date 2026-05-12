import 'package:data/models/base/base_response_model.dart';
import 'package:data/models/remote/todo/todo_dto.dart';
import 'package:retrofit/dio.dart';

abstract class TodoNetworkDataSource {
  Future<HttpResponse<BaseResponseModel>> getTodos();

  Future<HttpResponse<BaseResponseModel>> createTodo(TodoDto todo);

  Future<HttpResponse<BaseResponseModel>> updateTodo(TodoDto todo);

  Future<HttpResponse<BaseResponseModel>> deleteTodo(String id);
}

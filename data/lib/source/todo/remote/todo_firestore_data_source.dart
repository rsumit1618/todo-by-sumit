import 'package:data/models/remote/todo/todo_dto.dart';

abstract class TodoFirestoreDataSource {
  Future<void> upsertTodo(TodoDto todo);

  Future<void> deleteTodo({
    required String userId,
    required String todoId,
  });

  Future<List<TodoDto>> getTodos(String userId);
}

import 'package:data/models/local/todo_local_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoLocalModel>> getTodos();

  Future<TodoLocalModel> createTodo(TodoLocalModel todo);

  Future<TodoLocalModel> updateTodo(TodoLocalModel todo);

  Future<void> deleteTodo(String id);

  Future<void> upsertTodos(List<TodoLocalModel> todos);
}

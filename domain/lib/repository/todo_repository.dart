import 'package:dartz/dartz.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/errors/network_error.dart';

abstract class TodoRepository {
  Future<Either<LocalError, List<TodoEntity>>> getLocalTodos();

  Future<Either<LocalError, TodoEntity>> createLocalTodo(TodoEntity todo);

  Future<Either<LocalError, TodoEntity>> updateLocalTodo(TodoEntity todo);

  Future<Either<LocalError, bool>> deleteLocalTodo(String id);

  Future<Either<NetworkError, List<TodoEntity>>> syncTodos(String userId);
}

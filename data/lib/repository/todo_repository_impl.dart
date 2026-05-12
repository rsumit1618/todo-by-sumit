import 'package:dartz/dartz.dart';
import 'package:data/models/local/todo_local_model.dart';
import 'package:data/models/remote/todo/todo_dto.dart';
import 'package:data/source/todo/local/todo_local_data_source.dart';
import 'package:data/source/todo/remote/todo_firestore_data_source.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoLocalDataSource _localDataSource;
  final TodoFirestoreDataSource Function() _readFirestoreDataSource;

  TodoRepositoryImpl(
    this._localDataSource,
    this._readFirestoreDataSource,
  );

  @override
  Future<Either<LocalError, List<TodoEntity>>> getLocalTodos() async {
    try {
      final todos = await _localDataSource.getTodos();
      return Right(todos.map((todo) => todo.toEntity()).toList());
    } catch (error) {
      return Left(LocalError(
        message: error.toString(),
        localError: 1,
        cause: Exception(error.toString()),
      ));
    }
  }

  @override
  Future<Either<LocalError, TodoEntity>> createLocalTodo(TodoEntity todo) async {
    try {
      final created = await _localDataSource.createTodo(
        TodoLocalModel.fromEntity(todo),
      );
      return Right(created.toEntity());
    } catch (error) {
      return Left(LocalError(
        message: error.toString(),
        localError: 1,
        cause: Exception(error.toString()),
      ));
    }
  }

  @override
  Future<Either<LocalError, TodoEntity>> updateLocalTodo(TodoEntity todo) async {
    try {
      final updated = await _localDataSource.updateTodo(
        TodoLocalModel.fromEntity(todo),
      );
      return Right(updated.toEntity());
    } catch (error) {
      return Left(LocalError(
        message: error.toString(),
        localError: 1,
        cause: Exception(error.toString()),
      ));
    }
  }

  @override
  Future<Either<LocalError, bool>> deleteLocalTodo(String id) async {
    try {
      await _localDataSource.deleteTodo(id);
      return Right(true);
    } catch (error) {
      return Left(LocalError(
        message: error.toString(),
        localError: 1,
        cause: Exception(error.toString()),
      ));
    }
  }

  @override
  Future<Either<NetworkError, List<TodoEntity>>> syncTodos(String userId) async {
    try {
      final localTodos = await _localDataSource.getTodos();
      final firestoreDataSource = _readFirestoreDataSource();
      for (final localTodo in localTodos) {
        await firestoreDataSource.upsertTodo(
          TodoDto.fromEntity(localTodo.toEntity().copyWith(
            isSynced: true,
            userId: userId,
          )),
        );
      }

      final remoteTodos = await firestoreDataSource.getTodos(userId);
      final syncedLocalTodos = remoteTodos
          .map((todo) => TodoLocalModel.fromEntity(
                todo.toEntity(isSynced: true),
              ))
          .toList();
      await _localDataSource.upsertTodos(syncedLocalTodos);

      return Right(remoteTodos.map((todo) => todo.toEntity()).toList());
    } catch (error) {
      return Left(NetworkError(
        httpError: 502,
        message: error.toString(),
        cause: Exception(error.toString()),
      ));
    }
  }
}

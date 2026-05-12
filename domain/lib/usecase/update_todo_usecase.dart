import 'package:dartz/dartz.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/todo_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UpdateTodoUseCase
    extends BaseUseCase<LocalError, UpdateTodoUseCaseParam, TodoEntity> {
  final TodoRepository _todoRepository;

  UpdateTodoUseCase(this._todoRepository);

  @override
  Future<Either<LocalError, TodoEntity>> execute({
    required UpdateTodoUseCaseParam params,
  }) {
    return _todoRepository.updateLocalTodo(
      params.todo.copyWith(updatedAt: DateTime.now(), isSynced: false),
    );
  }
}

class UpdateTodoUseCaseParam extends Params {
  final TodoEntity todo;

  UpdateTodoUseCaseParam(this.todo);

  @override
  Either<AppError, bool> verify() => Right(todo.title.trim().isNotEmpty);
}

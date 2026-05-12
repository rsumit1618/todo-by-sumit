import 'package:dartz/dartz.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/todo_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreateTodoUseCase
    extends BaseUseCase<LocalError, CreateTodoUseCaseParam, TodoEntity> {
  final TodoRepository _todoRepository;

  CreateTodoUseCase(this._todoRepository);

  @override
  Future<Either<LocalError, TodoEntity>> execute({
    required CreateTodoUseCaseParam params,
  }) {
    final now = DateTime.now();
    final todo = TodoEntity(
      id: now.microsecondsSinceEpoch.toString(),
      title: params.title.trim(),
      description: params.description?.trim(),
      createdAt: now,
      updatedAt: now,
    );
    return _todoRepository.createLocalTodo(todo);
  }
}

class CreateTodoUseCaseParam extends Params {
  final String title;
  final String? description;

  CreateTodoUseCaseParam({
    required this.title,
    this.description,
  });

  @override
  Either<AppError, bool> verify() => Right(title.trim().isNotEmpty);
}

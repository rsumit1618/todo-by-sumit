import 'package:dartz/dartz.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/todo_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetLocalTodosUseCase
    extends BaseUseCase<LocalError, GetLocalTodosUseCaseParam, List<TodoEntity>> {
  final TodoRepository _todoRepository;

  GetLocalTodosUseCase(this._todoRepository);

  @override
  Future<Either<LocalError, List<TodoEntity>>> execute({
    required GetLocalTodosUseCaseParam params,
  }) {
    return _todoRepository.getLocalTodos();
  }
}

class GetLocalTodosUseCaseParam extends Params {
  @override
  Either<AppError, bool> verify() => Right(true);
}

import 'package:dartz/dartz.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/todo_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DeleteTodoUseCase
    extends BaseUseCase<LocalError, DeleteTodoUseCaseParam, bool> {
  final TodoRepository _todoRepository;

  DeleteTodoUseCase(this._todoRepository);

  @override
  Future<Either<LocalError, bool>> execute({
    required DeleteTodoUseCaseParam params,
  }) {
    return _todoRepository.deleteLocalTodo(params.id);
  }
}

class DeleteTodoUseCaseParam extends Params {
  final String id;

  DeleteTodoUseCaseParam(this.id);

  @override
  Either<AppError, bool> verify() => Right(id.isNotEmpty);
}

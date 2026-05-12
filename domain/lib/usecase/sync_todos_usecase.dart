import 'package:dartz/dartz.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/todo_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SyncTodosUseCase
    extends BaseUseCase<NetworkError, SyncTodosUseCaseParam, List<TodoEntity>> {
  final TodoRepository _todoRepository;

  SyncTodosUseCase(this._todoRepository);

  @override
  Future<Either<NetworkError, List<TodoEntity>>> execute({
    required SyncTodosUseCaseParam params,
  }) {
    return _todoRepository.syncTodos(params.userId);
  }
}

class SyncTodosUseCaseParam extends Params {
  final String userId;

  SyncTodosUseCaseParam(this.userId);

  @override
  Either<AppError, bool> verify() => Right(userId.isNotEmpty);
}

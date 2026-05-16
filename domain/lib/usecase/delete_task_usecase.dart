import 'package:dartz/dartz.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/task_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class DeleteTaskUseCase
    extends BaseUseCase<LocalError, DeleteTaskUseCaseParam, bool> {
  final TaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  @override
  Future<Either<LocalError, bool>> execute({
    required DeleteTaskUseCaseParam params,
  }) {
    return _taskRepository.deleteLocalTask(params.id);
  }
}

class DeleteTaskUseCaseParam extends Params {
  final String id;

  DeleteTaskUseCaseParam(this.id);

  @override
  Either<AppError, bool> verify() => Right(id.isNotEmpty);
}

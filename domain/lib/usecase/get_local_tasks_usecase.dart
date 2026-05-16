import 'package:dartz/dartz.dart';
import 'package:domain/entities/task_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/task_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetLocalTasksUseCase
    extends
        BaseUseCase<LocalError, GetLocalTasksUseCaseParam, List<TaskEntity>> {
  final TaskRepository _taskRepository;

  GetLocalTasksUseCase(this._taskRepository);

  @override
  Future<Either<LocalError, List<TaskEntity>>> execute({
    required GetLocalTasksUseCaseParam params,
  }) {
    return _taskRepository.getLocalTasks();
  }
}

class GetLocalTasksUseCaseParam extends Params {
  @override
  Either<AppError, bool> verify() => Right(true);
}

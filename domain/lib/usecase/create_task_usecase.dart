import 'package:dartz/dartz.dart';
import 'package:domain/entities/task_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/task_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreateTaskUseCase
    extends BaseUseCase<LocalError, CreateTaskUseCaseParam, TaskEntity> {
  final TaskRepository _taskRepository;

  CreateTaskUseCase(this._taskRepository);

  @override
  Future<Either<LocalError, TaskEntity>> execute({
    required CreateTaskUseCaseParam params,
  }) {
    final now = DateTime.now();
    final task = TaskEntity(
      id: now.microsecondsSinceEpoch.toString(),
      title: params.title.trim(),
      description: params.description?.trim(),
      createdAt: now,
      updatedAt: now,
    );
    return _taskRepository.createLocalTask(task);
  }
}

class CreateTaskUseCaseParam extends Params {
  final String title;
  final String? description;

  CreateTaskUseCaseParam({required this.title, this.description});

  @override
  Either<AppError, bool> verify() => Right(title.trim().isNotEmpty);
}

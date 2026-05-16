import 'package:dartz/dartz.dart';
import 'package:domain/entities/task_entity.dart';
import 'package:domain/errors/local_error.dart';

abstract class TaskRepository {
  Future<Either<LocalError, List<TaskEntity>>> getLocalTasks();

  Future<Either<LocalError, TaskEntity>> createLocalTask(TaskEntity task);

  Future<Either<LocalError, TaskEntity>> updateLocalTask(TaskEntity task);

  Future<Either<LocalError, bool>> deleteLocalTask(String id);
}

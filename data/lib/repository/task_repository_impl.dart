import 'package:dartz/dartz.dart';
import 'package:data/models/local/task_local_model.dart';
import 'package:data/source/task/local/task_local_data_source.dart';
import 'package:domain/entities/task_entity.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource _localDataSource;

  TaskRepositoryImpl(this._localDataSource);

  @override
  Future<Either<LocalError, List<TaskEntity>>> getLocalTasks() async {
    try {
      final tasks = await _localDataSource.getTasks();
      return Right(tasks.map((task) => task.toEntity()).toList());
    } catch (error) {
      return Left(
        LocalError(
          message: error.toString(),
          localError: 1,
          cause: Exception(error.toString()),
        ),
      );
    }
  }

  @override
  Future<Either<LocalError, TaskEntity>> createLocalTask(
    TaskEntity task,
  ) async {
    try {
      final created = await _localDataSource.createTask(
        TaskLocalModel.fromEntity(task),
      );
      return Right(created.toEntity());
    } catch (error) {
      return Left(
        LocalError(
          message: error.toString(),
          localError: 1,
          cause: Exception(error.toString()),
        ),
      );
    }
  }

  @override
  Future<Either<LocalError, TaskEntity>> updateLocalTask(
    TaskEntity task,
  ) async {
    try {
      final updated = await _localDataSource.updateTask(
        TaskLocalModel.fromEntity(task),
      );
      return Right(updated.toEntity());
    } catch (error) {
      return Left(
        LocalError(
          message: error.toString(),
          localError: 1,
          cause: Exception(error.toString()),
        ),
      );
    }
  }

  @override
  Future<Either<LocalError, bool>> deleteLocalTask(String id) async {
    try {
      await _localDataSource.deleteTask(id);
      return Right(true);
    } catch (error) {
      return Left(
        LocalError(
          message: error.toString(),
          localError: 1,
          cause: Exception(error.toString()),
        ),
      );
    }
  }
}

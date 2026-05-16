import 'package:data/models/local/task_local_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskLocalModel>> getTasks();

  Future<TaskLocalModel> createTask(TaskLocalModel task);

  Future<TaskLocalModel> updateTask(TaskLocalModel task);

  Future<void> deleteTask(String id);

  Future<void> upsertTasks(List<TaskLocalModel> tasks);
}

import 'package:data/helper/app_local_database_helper.dart';
import 'package:data/models/local/task_local_model.dart';
import 'package:data/source/task/local/task_local_data_source.dart';

class TaskLocalDataSourceImpl extends TaskLocalDataSource {
  final AppLocalDatabase _database;

  TaskLocalDataSourceImpl(this._database);

  @override
  Future<List<TaskLocalModel>> getTasks() async {
    final rows = _database.instance.select(
      'SELECT * FROM tasks ORDER BY updated_at DESC',
    );
    return rows.map((row) => TaskLocalModel.fromRow(row)).toList();
  }

  @override
  Future<TaskLocalModel> createTask(TaskLocalModel task) async {
    _upsert(task);
    return task;
  }

  @override
  Future<TaskLocalModel> updateTask(TaskLocalModel task) async {
    _upsert(task);
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    _database.instance.execute('DELETE FROM tasks WHERE id = ?', [id]);
  }

  @override
  Future<void> upsertTasks(List<TaskLocalModel> tasks) async {
    for (final task in tasks) {
      _upsert(task);
    }
  }

  void _upsert(TaskLocalModel task) {
    final values = task.toSqlValues();
    _database.instance.execute(
      '''
      INSERT INTO tasks (
        id,
        title,
        description,
        is_completed,
        created_at,
        updated_at,
        is_synced,
        user_id
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        title = excluded.title,
        description = excluded.description,
        is_completed = excluded.is_completed,
        updated_at = excluded.updated_at,
        is_synced = excluded.is_synced,
        user_id = excluded.user_id
      ''',
      [
        values['id'],
        values['title'],
        values['description'],
        values['is_completed'],
        values['created_at'],
        values['updated_at'],
        values['is_synced'],
        values['user_id'],
      ],
    );
  }
}

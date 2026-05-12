import 'package:data/helper/app_local_database_helper.dart';
import 'package:data/models/local/todo_local_model.dart';
import 'package:data/source/todo/local/todo_local_data_source.dart';

class TodoLocalDataSourceImpl extends TodoLocalDataSource {
  final AppLocalDatabase _database;

  TodoLocalDataSourceImpl(this._database);

  @override
  Future<List<TodoLocalModel>> getTodos() async {
    final rows = _database.instance.select(
      'SELECT * FROM todos ORDER BY updated_at DESC',
    );
    return rows.map((row) => TodoLocalModel.fromRow(row)).toList();
  }

  @override
  Future<TodoLocalModel> createTodo(TodoLocalModel todo) async {
    _upsert(todo);
    return todo;
  }

  @override
  Future<TodoLocalModel> updateTodo(TodoLocalModel todo) async {
    _upsert(todo);
    return todo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    _database.instance.execute('DELETE FROM todos WHERE id = ?', [id]);
  }

  @override
  Future<void> upsertTodos(List<TodoLocalModel> todos) async {
    for (final todo in todos) {
      _upsert(todo);
    }
  }

  void _upsert(TodoLocalModel todo) {
    final values = todo.toSqlValues();
    _database.instance.execute(
      '''
      INSERT INTO todos (
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

import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';

class AppLocalDatabase {
  late final Database instance;

  AppLocalDatabase._(this.instance);

  static Future<AppLocalDatabase> create() async {
    final directory = await getApplicationDocumentsDirectory();
    final db = sqlite3.open("${directory.path}/app.db");
    db.execute('''
      CREATE TABLE IF NOT EXISTS todos (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0,
        user_id TEXT
      );
    ''');

    return AppLocalDatabase._(db);
  }
}

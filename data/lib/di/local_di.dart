import 'package:data/helper/app_local_database_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/source/task/local/task_local_data_source.dart';
import 'package:data/source/task/local/task_local_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appLocalDatabaseProvider = Provider<AppLocalDatabase>((ref) {
  throw UnimplementedError("Override in main()");
});

final secureStorageProvider = Provider<SecureStorageHelper>(
  (ref) => SecureStorageHelper(),
);

final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>(
  (ref) => TaskLocalDataSourceImpl(ref.read(appLocalDatabaseProvider)),
);

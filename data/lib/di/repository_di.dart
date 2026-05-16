import 'package:data/di/local_di.dart';
import 'package:data/di/network_di.dart';
import 'package:data/repository/live_update_repository_impl.dart';
import 'package:data/repository/starter_repository_impl.dart';
import 'package:data/repository/task_repository_impl.dart';
import 'package:domain/repository/live_update_repository.dart';
import 'package:domain/repository/starter_repository.dart';
import 'package:domain/repository/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final starterRepositoryProvider = Provider<StarterRepository>(
  (ref) => StarterRepositoryImpl(ref.read(starterRemoteDataSourceProvider)),
);

final liveUpdateRepositoryProvider = Provider<LiveUpdateRepository>(
  (ref) => LiveUpdateRepositoryImpl(
    ref.read(liveUpdateRemoteDataSourceProvider),
  ),
);

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => TaskRepositoryImpl(ref.read(taskLocalDataSourceProvider)),
);

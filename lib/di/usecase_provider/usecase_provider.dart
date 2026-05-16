import 'package:data/di/repository_di.dart';
import 'package:domain/usecase/create_task_usecase.dart';
import 'package:domain/usecase/delete_task_usecase.dart';
import 'package:domain/usecase/get_local_tasks_usecase.dart';
import 'package:domain/usecase/get_dashboard_summary_usecase.dart';
import 'package:domain/usecase/get_live_updates_usecase.dart';
import 'package:domain/usecase/update_task_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getDashboardSummaryUseCaseProvider =
    Provider.autoDispose<GetDashboardSummaryUseCase>(
      (ref) => GetDashboardSummaryUseCase(ref.read(starterRepositoryProvider)),
    );

final getLocalTasksUseCaseProvider = Provider.autoDispose<GetLocalTasksUseCase>(
  (ref) => GetLocalTasksUseCase(ref.read(taskRepositoryProvider)),
);

final getLiveUpdatesUseCaseProvider = Provider.autoDispose<GetLiveUpdatesUseCase>(
  (ref) => GetLiveUpdatesUseCase(ref.read(liveUpdateRepositoryProvider)),
);

final createTaskUseCaseProvider = Provider.autoDispose<CreateTaskUseCase>(
  (ref) => CreateTaskUseCase(ref.read(taskRepositoryProvider)),
);

final updateTaskUseCaseProvider = Provider.autoDispose<UpdateTaskUseCase>(
  (ref) => UpdateTaskUseCase(ref.read(taskRepositoryProvider)),
);

final deleteTaskUseCaseProvider = Provider.autoDispose<DeleteTaskUseCase>(
  (ref) => DeleteTaskUseCase(ref.read(taskRepositoryProvider)),
);

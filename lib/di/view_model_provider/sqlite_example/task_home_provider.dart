import 'package:kick_stack/di/usecase_provider/usecase_provider.dart';
import 'package:kick_stack/presentation/sqlite_example/task_home_page_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final taskHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<TaskHomePageViewModel>(
      (ref) => TaskHomePageViewModel(
        getLocalTasksUseCase: ref.read(getLocalTasksUseCaseProvider),
        createTaskUseCase: ref.read(createTaskUseCaseProvider),
        updateTaskUseCase: ref.read(updateTaskUseCaseProvider),
        deleteTaskUseCase: ref.read(deleteTaskUseCaseProvider),
      ),
    );

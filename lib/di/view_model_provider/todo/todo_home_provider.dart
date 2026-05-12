import 'package:flutter_clean_architecture/di/usecase_provider/usecase_provider.dart';
import 'package:flutter_clean_architecture/presentation/todo/todo_home_page_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final todoHomeViewModelProvider =
    ChangeNotifierProvider.autoDispose<TodoHomePageViewModel>(
  (ref) => TodoHomePageViewModel(
    getLocalTodosUseCase: ref.read(getLocalTodosUseCaseProvider),
    createTodoUseCase: ref.read(createTodoUseCaseProvider),
    updateTodoUseCase: ref.read(updateTodoUseCaseProvider),
    deleteTodoUseCase: ref.read(deleteTodoUseCaseProvider),
    syncTodosUseCase: ref.read(syncTodosUseCaseProvider),
    readLoginWithEmailUseCase: () => ref.read(loginWithEmailUseCaseProvider),
    readRegisterWithEmailUseCase: () =>
        ref.read(registerWithEmailUseCaseProvider),
    readLoginWithGoogleUseCase: () => ref.read(loginWithGoogleUseCaseProvider),
    readGetCurrentAuthUserUseCase: () =>
        ref.read(getCurrentAuthUserUseCaseProvider),
  ),
);

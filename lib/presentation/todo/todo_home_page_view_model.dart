import 'package:domain/entities/auth_user_entity.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:domain/usecase/create_todo_usecase.dart';
import 'package:domain/usecase/delete_todo_usecase.dart';
import 'package:domain/usecase/get_current_auth_user_usecase.dart';
import 'package:domain/usecase/get_local_todos_usecase.dart';
import 'package:domain/usecase/login_with_email_usecase.dart';
import 'package:domain/usecase/login_with_google_usecase.dart';
import 'package:domain/usecase/register_with_email_usecase.dart';
import 'package:domain/usecase/sync_todos_usecase.dart';
import 'package:domain/usecase/update_todo_usecase.dart';
import 'package:flutter_clean_architecture/base/base_page_view_model.dart';

class TodoHomePageViewModel extends BasePageViewModel {
  final GetLocalTodosUseCase getLocalTodosUseCase;
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final SyncTodosUseCase syncTodosUseCase;
  final LoginWithEmailUseCase Function() readLoginWithEmailUseCase;
  final RegisterWithEmailUseCase Function() readRegisterWithEmailUseCase;
  final LoginWithGoogleUseCase Function() readLoginWithGoogleUseCase;
  final GetCurrentAuthUserUseCase Function() readGetCurrentAuthUserUseCase;

  List<TodoEntity> todos = [];
  AuthUserEntity? currentUser;
  bool isBusy = false;
  String? message;
  bool _hasLoaded = false;

  TodoHomePageViewModel({
    required this.getLocalTodosUseCase,
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.syncTodosUseCase,
    required this.readLoginWithEmailUseCase,
    required this.readRegisterWithEmailUseCase,
    required this.readLoginWithGoogleUseCase,
    required this.readGetCurrentAuthUserUseCase,
  });

  Future<void> load() async {
    if (_hasLoaded) return;
    _hasLoaded = true;
    await refresh();
  }

  Future<void> refresh() async {
    final result = await getLocalTodosUseCase.execute(
      params: GetLocalTodosUseCaseParam(),
    );
    result.fold(
      (error) => message = error.getFriendlyMessage(),
      (items) => todos = items,
    );
    notifyListeners();
  }

  Future<void> createTodo({
    required String title,
    String? description,
  }) async {
    if (title.trim().isEmpty) return;
    await _run(() async {
      final result = await createTodoUseCase.execute(
        params: CreateTodoUseCaseParam(
          title: title,
          description: description,
        ),
      );
      result.fold(
        (error) => message = error.getFriendlyMessage(),
        (_) => message = null,
      );
      await refresh();
    });
  }

  Future<void> toggleTodo(TodoEntity todo) async {
    await _run(() async {
      await updateTodoUseCase.execute(
        params: UpdateTodoUseCaseParam(
          todo.copyWith(isCompleted: !todo.isCompleted),
        ),
      );
      await refresh();
    });
  }

  Future<void> updateTitle(TodoEntity todo, String title) async {
    if (title.trim().isEmpty) return;
    await _run(() async {
      await updateTodoUseCase.execute(
        params: UpdateTodoUseCaseParam(todo.copyWith(title: title.trim())),
      );
      await refresh();
    });
  }

  Future<void> deleteTodo(String id) async {
    await _run(() async {
      await deleteTodoUseCase.execute(params: DeleteTodoUseCaseParam(id));
      await refresh();
    });
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    await _run(() async {
      final result = await readLoginWithEmailUseCase().execute(
        params: LoginWithEmailUseCaseParam(
          email: email,
          password: password,
        ),
      );
      result.fold(
        (error) => message = error.getFriendlyMessage(),
        (user) => currentUser = user,
      );
      notifyListeners();
    });
  }

  Future<void> registerWithEmail({
    required String email,
    required String password,
  }) async {
    await _run(() async {
      final result = await readRegisterWithEmailUseCase().execute(
        params: RegisterWithEmailUseCaseParam(
          email: email,
          password: password,
        ),
      );
      result.fold(
        (error) => message = error.getFriendlyMessage(),
        (user) => currentUser = user,
      );
      notifyListeners();
    });
  }

  Future<void> loginWithGoogle() async {
    await _run(() async {
      final result = await readLoginWithGoogleUseCase().execute(
        params: LoginWithGoogleUseCaseParam(),
      );
      result.fold(
        (error) => message = error.getFriendlyMessage(),
        (user) => currentUser = user,
      );
      notifyListeners();
    });
  }

  Future<void> syncTodos() async {
    final user = currentUser;
    if (user == null) {
      message = 'Login to sync todos';
      notifyListeners();
      return;
    }
    await _run(() async {
      final result = await syncTodosUseCase.execute(
        params: SyncTodosUseCaseParam(user.id),
      );
      result.fold(
        (error) => message = error.getFriendlyMessage(),
        (items) {
          todos = items;
          message = 'Todos synced';
        },
      );
      notifyListeners();
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    isBusy = true;
    notifyListeners();
    try {
      await action();
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }
}

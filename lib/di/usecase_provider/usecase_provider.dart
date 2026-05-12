import 'package:data/di/repository_di.dart';
import 'package:domain/usecase/create_todo_usecase.dart';
import 'package:domain/usecase/delete_todo_usecase.dart';
import 'package:domain/usecase/get_current_auth_user_usecase.dart';
import 'package:domain/usecase/get_local_todos_usecase.dart';
import 'package:domain/usecase/get_user_from_network_usecase.dart';
import 'package:domain/usecase/login_with_email_usecase.dart';
import 'package:domain/usecase/login_with_google_usecase.dart';
import 'package:domain/usecase/register_with_email_usecase.dart';
import 'package:domain/usecase/sync_todos_usecase.dart';
import 'package:domain/usecase/update_todo_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserFromNetworkUseCaseProvider = Provider.autoDispose<GetUserFromNetworkUseCase>(
      (ref) => GetUserFromNetworkUseCase(ref.read(userRepoProvider)),
);

final getLocalTodosUseCaseProvider = Provider.autoDispose<GetLocalTodosUseCase>(
  (ref) => GetLocalTodosUseCase(ref.read(todoRepositoryProvider)),
);

final createTodoUseCaseProvider = Provider.autoDispose<CreateTodoUseCase>(
  (ref) => CreateTodoUseCase(ref.read(todoRepositoryProvider)),
);

final updateTodoUseCaseProvider = Provider.autoDispose<UpdateTodoUseCase>(
  (ref) => UpdateTodoUseCase(ref.read(todoRepositoryProvider)),
);

final deleteTodoUseCaseProvider = Provider.autoDispose<DeleteTodoUseCase>(
  (ref) => DeleteTodoUseCase(ref.read(todoRepositoryProvider)),
);

final syncTodosUseCaseProvider = Provider.autoDispose<SyncTodosUseCase>(
  (ref) => SyncTodosUseCase(ref.read(todoRepositoryProvider)),
);

final loginWithEmailUseCaseProvider = Provider.autoDispose<LoginWithEmailUseCase>(
  (ref) => LoginWithEmailUseCase(ref.read(authRepositoryProvider)),
);

final registerWithEmailUseCaseProvider =
    Provider.autoDispose<RegisterWithEmailUseCase>(
  (ref) => RegisterWithEmailUseCase(ref.read(authRepositoryProvider)),
);

final loginWithGoogleUseCaseProvider =
    Provider.autoDispose<LoginWithGoogleUseCase>(
  (ref) => LoginWithGoogleUseCase(ref.read(authRepositoryProvider)),
);

final getCurrentAuthUserUseCaseProvider =
    Provider.autoDispose<GetCurrentAuthUserUseCase>(
  (ref) => GetCurrentAuthUserUseCase(ref.read(authRepositoryProvider)),
);

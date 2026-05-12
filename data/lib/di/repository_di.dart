import 'package:data/di/datasource_di.dart';
import 'package:data/di/local_di.dart';
import 'package:data/di/network_di.dart';
import 'package:data/mapper/user_dto_mapper.dart';
import 'package:data/repository/auth_repository_impl.dart';
import 'package:data/repository/todo_repository_impl.dart';
import 'package:data/repository/user_repository_impl.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/todo_repository.dart';
import 'package:domain/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Example structure:
// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   return AuthRepositoryImpl(
//     remoteSource: ref.read(firebaseAuthServiceProvider),
//   );
// });

var userRepoProvider = Provider<UserRepository>((ref) => UserRepositoryImpl(
    ref.read(userRepoProviderDs),
));

var userMapperProvider = Provider<UserMapper>((ref) => UserMapper());

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(
    ref.read(todoLocalDataSourceProvider),
    () => ref.read(todoFirestoreDataSourceProvider),
  ),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(firebaseAuthServiceProvider),
  ),
);

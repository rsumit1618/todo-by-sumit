import 'package:data/remote/firebase_auth_service.dart';
import 'package:data/remote/firestore_service.dart';
import 'package:data/source/todo/remote/todo_firestore_data_source.dart';
import 'package:data/source/todo/remote/todo_firestore_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_di.dart';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(
    ref.read(firebaseAuthProvider),
    ref.read(googleSignInProvider),
  );
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(
    ref.read(firestoreProvider),
  );
});

final todoFirestoreDataSourceProvider = Provider<TodoFirestoreDataSource>((ref) {
  return TodoFirestoreDataSourceImpl(
    ref.read(firestoreProvider),
  );
});

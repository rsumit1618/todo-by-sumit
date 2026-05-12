import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/models/remote/todo/todo_dto.dart';
import 'package:data/source/todo/remote/todo_firestore_data_source.dart';

class TodoFirestoreDataSourceImpl extends TodoFirestoreDataSource {
  final FirebaseFirestore _firestore;

  TodoFirestoreDataSourceImpl(this._firestore);

  @override
  Future<void> upsertTodo(TodoDto todo) {
    return _userTodos(todo.userId!).doc(todo.id).set(todo.toJson());
  }

  @override
  Future<void> deleteTodo({
    required String userId,
    required String todoId,
  }) {
    return _userTodos(userId).doc(todoId).delete();
  }

  @override
  Future<List<TodoDto>> getTodos(String userId) async {
    final snapshot =
        await _userTodos(userId).orderBy('updatedAt', descending: true).get();
    return snapshot.docs.map(TodoDto.fromFirestore).toList();
  }

  CollectionReference<Map<String, dynamic>> _userTodos(String userId) {
    return _firestore.collection('users').doc(userId).collection('todos');
  }
}

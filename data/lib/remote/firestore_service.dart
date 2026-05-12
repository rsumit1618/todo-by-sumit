import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<void> addUser(Map<String, dynamic> data) {
    return _firestore.collection("users").add(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String id) {
    return _firestore.collection("users").doc(id).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenUsers() {
    return _firestore.collection("users").snapshots();
  }
}
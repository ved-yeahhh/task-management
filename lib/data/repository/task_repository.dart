import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:task_mgmt/data/models/task_model.dart';
import 'package:task_mgmt/data/repository/auth_repository.dart';

class TaskRepository {
  // Define methods for task management (CRUD operations)
  final logger = Logger();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuthRepository authRepository = FirebaseAuthRepository();

  Future<void> addTask(Task task) async {
    final userId = authRepository.currentUser?.uid;
    if (userId == null) throw Exception("User not logged in");
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(task.id)
          .set(task.toMap());
    } catch (e) {
      logger.d("Error adding task: $e");
    }
  }

  Future<void> deleteTask(String taskId) async {
    await firestore
        .collection('users')
        .doc(authRepository.currentUser?.uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  Stream<List<Task>> getTasks() {
    final userId = authRepository.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty(); // no user logged in
    }

    return firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList(),
        );
  }

  Future<void> updateTask(Task task) async {
    await firestore
        .collection('users')
        .doc(authRepository.currentUser?.uid)
        .collection('tasks')
        .doc(task.id)
        .update(task.toMap());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saad_test/models/task_model.dart';
import 'package:saad_test/services/local_db_servic.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalDbService _localDb = LocalDbService();

  /// Fetch from Firestore and cache locally
  Future<List<TaskModel>> fetchTasksOnline() async {
    final snapshot = await _firestore.collection("tasks").get();

    final tasks = snapshot.docs
        .map((doc) => TaskModel.fromFirestore(doc))
        .toList();

    await _localDb.insertTasks(tasks);

    return tasks;
  }

  /// Fetch from SQLite
  Future<List<TaskModel>> fetchTasksOffline() async {
    return await _localDb.getTasks();
  }
}

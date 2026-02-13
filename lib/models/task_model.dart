import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String category;
  final int priority;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.createdAt,
  });

  /// Firestore → Model
  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'],
      category: data['category'],
      priority: data['priority'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "category": category,
      "priority": priority,
      "createdAt": createdAt,
    };
  }

  /// Model → SQLite
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "category": category,
      "priority": priority,
      "createdAt": createdAt.millisecondsSinceEpoch,
    };
  }

  /// SQLite → Model
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      priority: map['priority'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}

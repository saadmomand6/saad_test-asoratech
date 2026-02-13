import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:saad_test/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddTaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final titleController = TextEditingController();

  var selectedCategory = "Work".obs;
  var priority = 1.obs;
  var isLoading = false.obs;

  final List<String> categories = ["Work", "Personal", "Urgent"];

  Future<void> addTask() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar("Error", "Title cannot be empty");
      return;
    }

    try {
      isLoading.value = true;

      final docRef = _firestore.collection("tasks").doc();

      TaskModel task = TaskModel(
        id: docRef.id,
        title: titleController.text.trim(),
        category: selectedCategory.value,
        priority: priority.value,
        createdAt: DateTime.now(),
      );

      await docRef.set(task.toMap());

      Get.snackbar("Success", "Task added successfully");

      titleController.clear();
      priority.value = 1;
      selectedCategory.value = "Work";

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}

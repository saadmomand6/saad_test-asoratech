import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:saad_test/models/task_model.dart';
import 'package:saad_test/utils/custom_snackbar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final titleController = TextEditingController();

  var priority = 1.obs;
  var isLoading = false.obs;

  final List<String> categories = ["Work", "Personal", "Urgent"];
  // Reactive selected role Lodge
  final RxnString selectedCategory = RxnString();

  // to set role Lodge
  void setCategory(String? value) {
    selectedCategory.value = value;
  }

  Future<void> addTask() async {
    if (titleController.text.trim().isEmpty) {
      showCustomSnackbar(
        title: "Error",
        message: "Title cannot be empty",

        isError: true,
        fontSize: 16,
      );
      return;
    }

    try {
      isLoading.value = true;

      final docRef = _firestore.collection("Tasks").doc();

      TaskModel task = TaskModel(
        id: docRef.id,
        title: titleController.text.trim(),
        category: selectedCategory.value.toString(),
        priority: priority.value,
        createdAt: DateTime.now(),
      );

      await docRef.set(task.toFirestore());
Get.back(result: true);
      showCustomSnackbar(
        title: "Success",
        message: "Task added successfully",

        isError: false,
        fontSize: 16,
      );
      titleController.clear();
      priority.value = 1;
      selectedCategory.value = "Work";
     

    } catch (e) {
      showCustomSnackbar(
        title: "Error",
        message: e.toString(),

        isError: true,
        fontSize: 16,
      );
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saad_test/models/task_model.dart';
import 'package:saad_test/services/local_db_servic.dart';

class HomeController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;
  var isOffline = false.obs; // banner control

   // Selected filters
  final RxString selectedCategory = ''.obs;
  final RxString selectedSort = 'High → Low'.obs; // default sort

  late final Connectivity _connectivity;

  @override
  void onInit() {
    super.onInit();

    _connectivity = Connectivity();

    _connectivity.onConnectivityChanged.listen((result) {
      isOffline.value = result == ConnectivityResult.none;
    });

    fetchTasks();
  }
  void sortByPriorityFiltered(List<TaskModel> taskList) {
    taskList.sort((a, b) => b.priority.compareTo(a.priority));
  }

  void sortByPriority() {
    // Sort the whole list by priority
    tasks.sort((a, b) => b.priority.compareTo(a.priority));
    tasks.refresh();
  }

  Future<bool> _hasRealInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> fetchTasks({BuildContext? context}) async {
    isLoading.value = true;

    try {
      // final hasInternet = connectivityResult != ConnectivityResult.none;
      // isOffline.value = !hasInternet; // update banner immediately
      final hasInternet = await _hasRealInternet();
      isOffline.value = !hasInternet;
      if (hasInternet) {
        try {
          final snapshot = await FirebaseFirestore.instance
              .collection("Tasks")
              .get();

          final onlineTasks = snapshot.docs
              .map((doc) => TaskModel.fromFirestore(doc))
              .toList();
          tasks.assignAll(onlineTasks);

          if (onlineTasks.isNotEmpty) {
            await LocalDbService().insertTasks(onlineTasks);
          }
        } on FirebaseException catch (_) {
          // Firestore error → fallback offline
          final offlineTasks = await LocalDbService().getTasks();
          tasks.assignAll(offlineTasks);
          isOffline.value = true;
        } on SocketException catch (_) {
          final offlineTasks = await LocalDbService().getTasks();
          tasks.assignAll(offlineTasks);
          isOffline.value = true;
        } catch (_) {
          final offlineTasks = await LocalDbService().getTasks();
          tasks.assignAll(offlineTasks);
          isOffline.value = true;
        }
      } else {
        final offlineTasks = await LocalDbService().getTasks();
        tasks.assignAll(offlineTasks);
        isOffline.value = true;
      }
    } catch (_) {
      final offlineTasks = await LocalDbService().getTasks();
      tasks.assignAll(offlineTasks);
      isOffline.value = true;
    } finally {
      isLoading.value = false;
    }
  }


  void refreshApp({BuildContext? context}) {
    fetchTasks(context: context);
  }
}

import 'package:get/get.dart';
import 'package:saad_test/models/task_model.dart';
import 'package:saad_test/repositories/task_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController extends GetxController {
  final TaskRepository _repository = TaskRepository();

  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;
  var isSortedByPriority = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;

      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.none) {
        tasks.value = await _repository.fetchTasksOnline();
      } else {
        tasks.value = await _repository.fetchTasksOffline();
      }
    } catch (e) {
      tasks.value = await _repository.fetchTasksOffline();
    } finally {
      isLoading.value = false;
    }
  }

  void sortByPriority() {
    isSortedByPriority.toggle();

    tasks.sort((a, b) => b.priority.compareTo(a.priority));
    tasks.refresh();
  }
}

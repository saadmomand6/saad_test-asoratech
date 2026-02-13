import 'package:get/get.dart';
import 'package:saad_test/view_models/home_view_model.dart';
import 'package:saad_test/view_models/task_view_models.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AddTaskController());
  }
}

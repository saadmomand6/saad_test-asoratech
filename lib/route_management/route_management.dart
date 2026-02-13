import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:saad_test/bindings/bindings.dart';
import 'package:saad_test/routes/routes.dart';
import 'package:saad_test/views/add_tasks_screen.dart';
import 'package:saad_test/views/home_screen.dart';

class Pages {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: PrimaryRoute.addTask,
        page: () => AddTaskScreen(),
        binding: ControllerBindings(),
      ),
      GetPage(
        name: PrimaryRoute.home,
        page: () => HomeScreen(),
        binding: ControllerBindings(),
      ),
    ];
  }
}

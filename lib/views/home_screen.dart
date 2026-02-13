import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saad_test/constants/colors.dart';
import 'package:saad_test/view_models/home_view_model.dart';
import 'package:saad_test/views/add_tasks_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textBlueColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        title: const Text(
          "Task Manager",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: AppColors.whiteColor),
            onPressed: controller.sortByPriority,
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.whiteColor),
            onPressed: () => controller.refreshApp(context: context),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () async {
              final result = await Get.to(() => AddTaskScreen());
              if (result == true) {
                controller.fetchTasks(context: context);
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Obx(
              () => controller.isOffline.value
                  ? Container(
                      width: double.infinity,
                      color: Colors.red,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "Offline Mode",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(),
            ),


            // Tasks or "No Tasks Found"
            Expanded(
              child: controller.tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No Tasks Found",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        final task = controller.tasks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Category: ${task.category}"),
                                Text(
                                  "Created: ${task.createdAt.toLocal().toString().split('.').first}",
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                task.priority,
                                (_) => const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saad_test/view_models/home_view_model.dart';
import 'package:saad_test/views/add_tasks_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        actions: [
          /// Sort Icon
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: controller.sortByPriority,
          ),

          /// Navigate to Add Screen
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => AddTaskScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tasks.isEmpty) {
          return const Center(child: Text("No Tasks Found"));
        }

        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];

            return Card(
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.category),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    task.priority,
                    (index) =>
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saad_test/view_models/task_view_models.dart';
class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final AddTaskController controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Title Field
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                labelText: "Task Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// Category Dropdown
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedCategory.value,
                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),
                  items: controller.categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedCategory.value = value!;
                  },
                )),

            const SizedBox(height: 20),

            /// Priority Rating (Stars)
            const Text("Priority"),

            const SizedBox(height: 10),

            Obx(() => Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        controller.priority.value = index + 1;
                      },
                      icon: Icon(
                        Icons.star,
                        color: controller.priority.value > index
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    );
                  }),
                )),

            const SizedBox(height: 30),

            /// Add Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.addTask,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Add Task"),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

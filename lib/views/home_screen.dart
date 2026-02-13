import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saad_test/constants/colors.dart';
import 'package:saad_test/models/task_model.dart';
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

        // 🔴 Offline Banner
        Widget offlineBanner = controller.isOffline.value
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
            : const SizedBox();

        // 🔹 Filters row (Category + Sort)
        Widget filterRow = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              // Category Dropdown
              Expanded(
                child: Obx(() {
                  final categories = controller.tasks
                      .map((t) => t.category)
                      .toSet()
                      .toList();
                  categories.insert(0, 'All');
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: controller.selectedCategory.value.isEmpty
                          ? 'All'
                          : controller.selectedCategory.value,
                      dropdownColor: AppColors.blackColor,
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: categories
                          .map(
                            (cat) =>
                                DropdownMenuItem(value: cat, child: Text(cat)),
                          )
                          .toList(),
                      onChanged: (value) =>
                          controller.selectedCategory.value = value ?? 'All',
                    ),
                  );
                }),
              ),

              const SizedBox(width: 12),

              // Sort Dropdown
              Obx(() {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedSort.value,
                    dropdownColor: AppColors.blackColor,
                    style: const TextStyle(color: Colors.white),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'High → Low',
                        child: Text('High → Low'),
                      ),
                      DropdownMenuItem(
                        value: 'Low → High',
                        child: Text('Low → High'),
                      ),
                    ],
                    onChanged: (value) =>
                        controller.selectedSort.value = value ?? 'High → Low',
                  ),
                );
              }),
            ],
          ),
        );

        // 🔹 Filtered & Sorted Tasks
        List<TaskModel> filteredTasks =
            controller.selectedCategory.value == 'All' || controller.selectedCategory.value.isEmpty
            ? controller.tasks.toList()
            : controller.tasks
                  .where((t) => t.category == controller.selectedCategory.value)
                  .toList();

        if (controller.selectedSort.value == 'High → Low') {
          filteredTasks.sort((a, b) => b.priority.compareTo(a.priority));
        } else {
          filteredTasks.sort((a, b) => a.priority.compareTo(b.priority));
        }

        // 🔹 Task List
        Widget bodyContent = filteredTasks.isEmpty
            ? const Center(
                child: Text(
                  "No Tasks Found",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
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
              );

        return Column(
          children: [
            offlineBanner,
            filterRow,
            Expanded(child: bodyContent),
          ],
        );
      }),
    );
  }
}

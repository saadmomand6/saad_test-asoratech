import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saad_test/constants/colors.dart';
import 'package:saad_test/utils/custom_button.dart';
import 'package:saad_test/utils/custom_dropdown.dart';
import 'package:saad_test/utils/custom_spaces.dart';
import 'package:saad_test/utils/custom_textfield.dart';
import 'package:saad_test/view_models/task_view_models.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final AddTaskController controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textBlueColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Obx(
                () => CustomButton(
                  showBorder: false,
                  isIcon: false,
                  height: Get.height * 0.06,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.buttonlinearYellowColor,
                      AppColors.buttonlinearLightYellowColor,
                    ],
                  ),

                  title: "Add Task",
                  textColor: AppColors.blackColor,
                  isLoading: controller.isLoading.value,
                  pressed: () {
                    controller.addTask();
                  },
                ),
              ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.whiteColor),
          onPressed: () {
            Get.back();
          },
        ),

        title: const Text("Add Task", style: TextStyle(color: AppColors.whiteColor),), centerTitle: true, backgroundColor: AppColors.blackColor,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
             const Text(
              "Title",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
             SpaceH20(),
            /// Title Field
            CustomTextField(
              obscureText: false,
              inputType: TextInputType.name,
              controller: controller.titleController,
              radius: 10,
              textAlign: TextAlign.center,
              inputTextColor: AppColors.textBlueColor,
              fontSize: 16,
              fontweight: FontWeight.bold,
              fieldColor: AppColors.whiteColor,
              hintColor: AppColors.textBlueColor,
              hintText: "Enter Title",
            ),

            SpaceH20(),
             const Text(
              "Category",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
             SpaceH20(),
            Obx(
              () => CustomDropdown<String>(
                
                items: controller.categories,
                selectedItem: controller.selectedCategory.value,
                hintText: "Select Task Category",
                onChanged: (value) {
                  controller.setCategory(value);
                },
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.linearDarkBlueColor,
                  ),
                ),
              ),
            ),

            SpaceH30(),

            const Text("Priority", style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold, fontSize: 20),),
            SpaceH10(),

            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      controller.priority.value = index + 1;
                    },
                    icon: Icon(
                      Icons.star,
                      color: controller.priority.value > index
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

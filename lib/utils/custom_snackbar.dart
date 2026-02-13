import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

// Method to show a custom snackbar
void showCustomSnackbar({
  required String title,
  required String message,
  required bool isError,
  required double fontSize,

  Duration duration = const Duration(seconds: 3),
  SnackPosition snackPosition = SnackPosition.TOP,
}) {
  Get.snackbar(
    '',
    '',
    snackPosition: snackPosition,
    duration: duration,
    titleText: Text(
      title,
      style: TextStyle(fontSize: fontSize, color: AppColors.whiteColor),
    ),
    messageText: Text(
      message,
      style: TextStyle(fontSize: fontSize, color: AppColors.whiteColor),
      textAlign: TextAlign.left,
    ),
    backgroundColor: isError
        ? AppColors.textRed.withValues(alpha: 0.8)
        : AppColors.green.withValues(alpha: 0.8),
  );
}

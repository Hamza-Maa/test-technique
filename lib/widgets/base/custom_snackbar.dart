import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String message) {
  Get.snackbar(
    "Notice".tr,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black87,
    colorText: Colors.white,
    borderRadius: 12,
    margin: const EdgeInsets.all(12),
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.info, color: Colors.white),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showSuccessSnackbar(String message) {
  Get.snackbar(
    "Success".tr,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.shade600,
    colorText: Colors.white,
    borderRadius: 12,
    margin: const EdgeInsets.all(12),
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.check_circle, color: Colors.white),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showErrorSnackbar(String message) {
  Get.snackbar(
    "Error".tr,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.shade600,
    colorText: Colors.white,
    borderRadius: 12,
    margin: const EdgeInsets.all(12),
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.error, color: Colors.white),
    snackStyle: SnackStyle.FLOATING,
  );
}

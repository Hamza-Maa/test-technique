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

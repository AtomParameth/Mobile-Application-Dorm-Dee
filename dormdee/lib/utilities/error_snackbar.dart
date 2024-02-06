import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackbar(title, message) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3));
}

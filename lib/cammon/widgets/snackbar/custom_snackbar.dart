import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/dimensions.dart';

void showCustomSnackBar(String? message, {bool isError = true, Color? color}) {
  if(message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 10),
      backgroundColor: color ?? (isError ? Colors.red : Colors.green),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
    ));
  }
}
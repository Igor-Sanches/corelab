import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/dimensions.dart';

void showCustomSnackBarNoConnection(Response? response) {
  String msg = response == null ? 'not_internet_msg'.tr : response.statusText!;
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 10),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(response == null ? 'Não foi possivel se conectar, tente novamente!' : msg),
  ));
}
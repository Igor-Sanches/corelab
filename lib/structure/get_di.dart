import 'dart:convert';
import 'package:corelab/features/category/controller/category_controller.dart';
import 'package:corelab/features/category/repository/category_repository.dart';
import 'package:corelab/features/home/controller/product_controller.dart';
import 'package:corelab/features/search/controller/search_controller.dart';
import 'package:corelab/features/home/repository/product_repository.dart';
import 'package:corelab/features/search/repository/search_repository.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../application/controller/root_controller.dart';
import '../application/controller/theme_controller.dart';
import '../utilities/app_constants.dart';

Future<List<dynamic>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // Repository Root
  Get.lazyPut(() => ProductRepository());
  Get.lazyPut(() => CategoryRepository());
  Get.lazyPut(() => SearchRepository(sharedPreferences: Get.find()));

  // Controller Root
  Get.lazyPut(() => RootController());
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ProductController(repository: Get.find()));
  Get.lazyPut(() => CategoryController(repository: Get.find()));
  Get.lazyPut(() => SearchController(repository: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  String jsonStringValues =  await rootBundle.loadString('assets/language/${AppConstants.languageCode}.json');
  Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
  Map<String, String> jsonLanguage = {};
  mappedJson.forEach((key, value) {
    jsonLanguage[key] = value.toString();
  });
  languages['${AppConstants.languageCode}_${AppConstants.countryCode}'] = jsonLanguage;

  bool isBiometry = false;
  return [
    languages,
    isBiometry
  ];
}

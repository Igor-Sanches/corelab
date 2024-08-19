import 'package:corelab/application/models/category.dart';
import 'package:get/get.dart';

import '../repository/category_repository.dart';

class CategoryController extends GetxController implements GetxService{
  final CategoryRepository repository;

  CategoryController({required this.repository});

  List<Category>? _categories;

  List<Category>? get categories => _categories;

  Future<void> getCategories()async{
    _categories ??= await repository.getCategories();
    update();
  }

}
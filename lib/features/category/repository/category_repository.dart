import 'dart:convert';

import 'package:corelab/utilities/extensions.dart';
import 'package:flutter/services.dart';

import '../../../application/models/category.dart';

class CategoryRepository{

  Future<List<Category>> getCategories() async{

    var jsonStringValues = await rootBundle.loadString('assets/stock/products.json');

    if(jsonStringValues.isNotEmpty){
      var json = jsonDecode(jsonStringValues);

      var list = <Category>[].addCategory(json);

      list.sort((a, b) => a.category.compareTo(b.category));

      return list;
    }

    return [];

  }
}
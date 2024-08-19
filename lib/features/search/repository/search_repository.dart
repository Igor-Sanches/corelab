import 'dart:convert';

import 'package:corelab/application/models/product.dart';
import 'package:corelab/utilities/extensions.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utilities/app_constants.dart';

class SearchRepository{
  final SharedPreferences sharedPreferences;

  SearchRepository({required this.sharedPreferences});

  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.searchHistory, searchHistories);
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.searchHistory) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.searchHistory, []);
  }

  Future<List<Product>?> getSearchData(String query) async{

    var jsonStringValues = await rootBundle.loadString('assets/stock/products.json');

    if(jsonStringValues.isNotEmpty){
      var json = jsonDecode(jsonStringValues);

      List<Product> products = List.from(json).map((item) => Product.fromJson(item)).toList();

      return <Product>[].querySearch(query, products);
    }

    return null;

  }
}
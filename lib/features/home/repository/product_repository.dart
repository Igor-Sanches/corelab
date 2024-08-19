import 'dart:convert';

import 'package:corelab/application/models/product.dart';
import 'package:corelab/utilities/extensions.dart';
import 'package:flutter/services.dart';

import "package:collection/collection.dart" show groupBy;

import '../../../application/models/product_model.dart';

class ProductRepository{

  Future<List<ProductModel>> getProducts() async{

    var jsonStringValues = await rootBundle.loadString('assets/stock/products.json');

    if(jsonStringValues.isNotEmpty){
      var json = jsonDecode(jsonStringValues);

      List<Product> products = List.from(json).map((item) => Product.fromJson(item)).toList();

      var group = groupBy(products, (Product p) => p.createAt);

      return <ProductModel>[].addAllProducts(group);
    }

    return [];

  }
}
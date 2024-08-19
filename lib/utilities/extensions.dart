import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:price_converter/price_converter.dart';

import '../application/models/category.dart';
import '../application/models/product.dart';
import '../application/models/product_model.dart';

extension StringExtension on String{
  String? replaceArray(List<String> list, String replaceTo){
    var value = this;
    for(var _ in list){
      value = replaceAll(_, replaceTo);
    }

    return value;
  }

  String toDateAgo(){
    var dateTime = DateTime.parse('$this 00:00:00');
    return GetTimeAgo.parse(dateTime, locale: 'pt', pattern: 'd, MMM yyyy');
  }
}

extension Values on dynamic{

  String noNull(){
    if(this == null){
      return '';
    }
    return this;
  }
}

extension DoubleExtension on double{

  String toPrice(){
    return PriceConverter.getFormattedPrice(currency: "R\$", price: this);
  }

}

extension ProductModelExtension on List<ProductModel>{

  List<ProductModel> addAllProducts(Map<String?, List<Product>> group){
    addAll([]);
    group.forEach((createAt, products){
      add(ProductModel(createAt: createAt!, products: products));
    });

    return this;
  }

}

extension ProductExtension on List<Product>{
  List<Product>? querySearch(query, List<Product> products){
    addAll(products.where((p) => p.descriptionSearch(query)));

    return isEmpty ? null : this;
  }
}

extension CategoryExtension on List<Category>{

  List<Category> addCategory(json){
    addAll([]);
    for (var item in json) {
      if(firstWhereOrNull((c) => c.category == item['category']) == null){
        add(Category(category: item['category']));
      }
    }
    return this;
  }

}
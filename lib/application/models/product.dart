import 'package:corelab/utilities/constents.dart';

class Product{
  String? description;
  String? image;
  double? price;
  double? discount;
  bool? isNew;
  String? category;
  String? createAt;

  String get imageProduct => 'assets/images/$image';

  double get priceProduct => hasDiscount ? price! - (price!*discount!/100) : price!;

  bool get hasDiscount => discount! > 0;

  String get discountPercentage => '$discount%';

  Product.fromJson(item) {
    if(item == null){
      return;
    }

    description = toString(item["description"]);
    image = toString(item["image"]);
    price = toDouble(item["price"]);
    discount = toDouble(item["discount"]);
    isNew = toBool(item["is_new"]);
    category = toString(item["category"]);
    createAt = toString(item["create_at"]);
  }

  bool descriptionSearch(String query) {
    if(description == null){
      return false;
    }

    if(description!.toLowerCase().contains(query.toLowerCase())){
      return true;
    }
    return false;

  }
}
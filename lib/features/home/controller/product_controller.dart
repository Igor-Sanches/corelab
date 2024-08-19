import 'package:get/get.dart';

import '../../../application/models/product_model.dart';
import '../repository/product_repository.dart';

class ProductController extends GetxController implements GetxService{
  final ProductRepository repository;

  ProductController({required this.repository});

  List<ProductModel>? _productModel;

  List<ProductModel>? get products => _productModel;

  Future<void> getProducts()async{
    _productModel ??= await repository.getProducts();
    update();
  }

}
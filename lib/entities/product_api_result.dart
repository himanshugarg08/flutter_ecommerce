import 'package:flutter_ecommerce_project/entities/product.dart';

abstract class ProductApiResult {}

class ProductApiResultNoProducts implements ProductApiResult {}

class ProductApiResultLoading implements ProductApiResult {}

class ProductApiResultwithProducts implements ProductApiResult {
  final List<Product> productList;
  ProductApiResultwithProducts(this.productList);
}

class ProductApiResultError implements ProductApiResult {
  final Object error;
  ProductApiResultError(this.error);
}

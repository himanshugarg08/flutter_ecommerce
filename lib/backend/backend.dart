import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_project/entities/product.dart';
import 'package:flutter_ecommerce_project/entities/product_api_result.dart';

const jsonFile = 'assets/products.json';

class Backend {
  Future<ProductApiResult> _loadDataFromFile(String jsonFileAsset) async {
    final response = await rootBundle.loadString(jsonFile);
    final data = json.decode(response);

    if (data == null) {
      return ProductApiResultError("No Data");
    }

    final productList =
        List.from(data).map((product) => Product.fromJson(product)).toList();

    if (productList.isEmpty) {
      return ProductApiResultNoProducts();
    }

    return ProductApiResultwithProducts(productList);
  }

  Future<ProductApiResult> getAllProducts() async {
    // intentional delay to mock api call
    await Future.delayed(const Duration(seconds: 1));

    final result = await _loadDataFromFile(jsonFile);
    return result;
  }

  Future<Product?> getProductFromId(String productId) async {
    // intentional delay to mock api call
    await Future.delayed(const Duration(seconds: 1));

    final result = await _loadDataFromFile(jsonFile);

    if (result is ProductApiResultwithProducts) {
      final allProducts = result.productList;
      final product =
          allProducts.firstWhere((element) => element.id == productId);
      return product;
    }

    return null;
  }
}

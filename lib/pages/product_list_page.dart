import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/entities/product_api_result.dart';
import 'package:flutter_ecommerce_project/pages/cart_items_page.dart';
import 'package:flutter_ecommerce_project/views/cart_view.dart';
import 'package:flutter_ecommerce_project/widgets/cart_widget.dart';
import 'package:flutter_ecommerce_project/providers/product_providers.dart';
import 'package:flutter_ecommerce_project/views/product_view.dart';
import 'package:flutter_ecommerce_project/widgets/product_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  late final ProductView _productView;
  late final CartView _cartView;

  @override
  void initState() {
    super.initState();
    _productView = ref.read(productViewProvider);
    _cartView = ref.read(cartViewProvider);

    _productView.init();
    _cartView.init();
  }

  @override
  void dispose() {
    _productView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ecommerce App"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CartWidget(onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartItemsPage(),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        initialData: ProductApiResultNoProducts(),
        stream: _productView.productApiResultStream,
        builder: (context, snapshot) {
          final result = snapshot.data;

          if (result is ProductApiResultLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (result is ProductApiResultNoProducts) {
            return const Center(child: Text("No Products"));
          }

          if (result is ProductApiResultError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (result is ProductApiResultwithProducts) {
            final productList = result.productList;
            return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: ProductWidget(
                      product: product,
                      onPressed: () {
                        _cartView.addProductToCart(product);
                      },
                    ),
                  );
                });
          }
          return const Center(child: Text("Unknown State"));
        },
      ),
    );
  }
}

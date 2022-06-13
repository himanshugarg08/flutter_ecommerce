import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/entities/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final VoidCallback? onPressed;
  const ProductWidget({Key? key, required this.product, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image.network(product.images.first),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name),
              Text(product.price),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add_shopping_cart_rounded),
          ),
        ],
      ),
    );
  }
}

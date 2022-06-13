import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/entities/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback? onRemove;

  final VoidCallback? onAdd;

  const CartItemWidget({
    Key? key,
    required this.item,
    this.onRemove,
    this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final itemQuantity = item.quantity;
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
          Column(
            children: [
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.remove_circle),
              ),
              Text(itemQuantity.toString()),
              IconButton(
                onPressed: onAdd,
                icon: const Icon(Icons.add_circle),
              ),
            ],
          )
        ],
      ),
    );
  }
}

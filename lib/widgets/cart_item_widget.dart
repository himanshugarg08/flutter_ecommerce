import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/entities/cart.dart';

const currencySymbol = '\u20B9';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.orange.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  product.images.first,
                  errorBuilder: (context, error, stackTrace) => const FittedBox(
                    child: Text("Error Loading Image"),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "$currencySymbol${product.price}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red.shade400,
                  ),
                ),
                Text(itemQuantity.toString()),
                IconButton(
                  onPressed: onAdd,
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green.shade400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

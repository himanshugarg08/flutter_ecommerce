import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/entities/product.dart';

const currencySymbol = '\u20B9';

class ProductWidget extends StatelessWidget {
  final Product product;
  final VoidCallback? onPressed;
  const ProductWidget({Key? key, required this.product, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blue.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.add_shopping_cart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

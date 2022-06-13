import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/entities/cart.dart';
import 'package:flutter_ecommerce_project/providers/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartWidget extends ConsumerWidget {
  final VoidCallback? onPressed;
  const CartWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartView = ref.watch(cartViewProvider);
    return StreamBuilder<Cart>(
      stream: cartView.cartStream,
      initialData: const Cart.empty(),
      builder: ((context, snapshot) {
        return GestureDetector(
          onTap: onPressed,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.add_shopping_cart_rounded,
                size: 24,
              ),
              Positioned(
                top: -8,
                right: -8,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Text(
                      cartView.cartProductQuantity.toString(),
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

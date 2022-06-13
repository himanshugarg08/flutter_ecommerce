import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/entities/cart.dart';
import 'package:flutter_ecommerce_project/providers/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const currencySymbol = '\u20B9';

class AmountWidget extends ConsumerWidget {
  const AmountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartView = ref.watch(cartViewProvider);
    return StreamBuilder<Cart>(
      stream: cartView.cartStream,
      initialData: const Cart.empty(),
      builder: ((context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "$currencySymbol${cartView.calculateCartTotalAmount}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        );
      }),
    );
  }
}

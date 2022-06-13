import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_project/views/cart_view.dart';
import 'package:flutter_ecommerce_project/widgets/amount_widget.dart';
import 'package:flutter_ecommerce_project/widgets/cart_item_widget.dart';
import 'package:flutter_ecommerce_project/widgets/cart_widget.dart';
import 'package:flutter_ecommerce_project/entities/cart.dart';
import 'package:flutter_ecommerce_project/providers/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemsPage extends ConsumerStatefulWidget {
  const CartItemsPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartItemsPage> {
  late final CartView _cartView;

  @override
  void initState() {
    super.initState();
    _cartView = ref.read(cartViewProvider);
  }

  void onPurchase() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Payment Successful"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CartWidget(),
            ),
          ),
        ],
      ),
      body: StreamBuilder<Cart>(
        initialData: const Cart.empty(),
        stream: _cartView.cartStream,
        builder: (context, snapshot) {
          final cart = snapshot.data!;
          final cartItems = cart.cartItems;

          if (cartItems.isEmpty) {
            return const Center(child: Text("No Products to show"));
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return CartItemWidget(
                item: cartItem,
                onAdd: () => _cartView.addProductToCart(cartItem.product),
                onRemove: () =>
                    _cartView.removeProductFromCart(cartItem.product),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StreamBuilder<Cart>(
          initialData: const Cart.empty(),
          stream: _cartView.cartStream,
          builder: (context, snapshot) {
            final cart = snapshot.data!;
            final cartItems = cart.cartItems;

            if (cartItems.isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AmountWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _cartView.clearCart(),
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Clear cart"),
                        ),
                      ),
                      GestureDetector(
                        onTap: onPurchase,
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Purchase"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

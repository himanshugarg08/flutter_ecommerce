import 'package:flutter_ecommerce_project/entities/product.dart';

typedef Quantity = int;
typedef ProductId = String;

class Cart {
  final int totalQuantity;
  final int totalAmount;
  final List<CartItem> cartItems;
  const Cart({
    required this.cartItems,
    required this.totalQuantity,
    required this.totalAmount,
  });

  const Cart.empty()
      : cartItems = const [],
        totalQuantity = 0,
        totalAmount = 0;

  Cart copyWith({
    int? totalQuantity,
    final int? totalAmount,
    final List<CartItem>? cartItems,
  }) {
    return Cart(
      cartItems: cartItems ?? this.cartItems,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

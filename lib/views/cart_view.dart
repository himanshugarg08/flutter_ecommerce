import 'package:flutter_ecommerce_project/entities/cart.dart';
import 'package:flutter_ecommerce_project/entities/product.dart';

import 'package:rxdart/rxdart.dart';

class CartView {
  late final BehaviorSubject<Cart> _cartSubject;

  Cart get cart => _cartSubject.value;

  Stream<Cart> get cartStream => _cartSubject.stream;

  void init() {
    _cartSubject = BehaviorSubject<Cart>.seeded(const Cart.empty());
  }

  int get cartProductQuantity => cart.totalQuantity;

  double get calculateCartTotalAmount => cart.totalAmount.toDouble();

  void addProductToCart(Product product) {
    Cart tempCart = cart;

    var prevCartItems = [...tempCart.cartItems];

    final itemIndexInCart = prevCartItems.indexWhere(
      (element) => element.product.id == product.id,
    );

    late CartItem newItem;

    if (itemIndexInCart != -1) {
      var previtem = prevCartItems[itemIndexInCart];
      prevCartItems[itemIndexInCart] =
          previtem.copyWith(quantity: previtem.quantity + 1);
      tempCart = tempCart.copyWith(
        cartItems: prevCartItems,
        totalQuantity: tempCart.totalQuantity + 1,
        totalAmount: tempCart.totalAmount + int.parse(product.price),
      );
    } else {
      newItem = CartItem(product: product, quantity: 1);
      tempCart = tempCart.copyWith(
        cartItems: prevCartItems..add(newItem),
        totalQuantity: tempCart.totalQuantity + 1,
        totalAmount: tempCart.totalAmount + int.parse(product.price),
      );
    }
    updateCart(tempCart);
  }

  void removeProductFromCart(Product product) {
    Cart tempCart = cart;
    final prevCartItems = tempCart.cartItems;

    final itemIndexInCart = prevCartItems.indexWhere(
      (element) => element.product.id == product.id,
    );

    if (itemIndexInCart != -1) {
      var previtem = prevCartItems[itemIndexInCart];
      if (previtem.quantity > 1) {
        prevCartItems[itemIndexInCart] =
            previtem.copyWith(quantity: previtem.quantity - 1);
      } else {
        tempCart.cartItems.removeWhere(
          (element) => element.product.id == product.id,
        );
      }
      tempCart = tempCart.copyWith(
        totalAmount: cart.totalAmount - int.parse(product.price),
        totalQuantity: cart.totalQuantity - 1,
      );
      updateCart(tempCart);
    } else {
      // do nothing
      // hard to reach
    }
  }

  void clearCart() {
    updateCart(const Cart.empty());
  }

  updateCart(Cart updatedCart) {
    _cartSubject.add(updatedCart);
  }

  void dispose() {
    _cartSubject.close();
  }
}

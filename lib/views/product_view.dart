import 'package:flutter_ecommerce_project/backend/backend.dart';
import 'package:flutter_ecommerce_project/entities/cart.dart';
import 'package:flutter_ecommerce_project/entities/product.dart';
import 'package:flutter_ecommerce_project/entities/product_api_result.dart';
import 'package:rxdart/rxdart.dart';

class ProductView {
  late final BehaviorSubject<ProductApiResult> _productListSubject;
  late final BehaviorSubject<Cart> _cartSubject;

  final Backend _backend;

  ProductView({required Backend backend}) : _backend = backend;

  ProductApiResult get productApiResult => _productListSubject.value;
  Cart get cart => _cartSubject.value;

  Stream<ProductApiResult> get productApiResultStream =>
      _productListSubject.stream.distinct();
  Stream<Cart> get cartStream => _cartSubject.stream;

  void init() {
    _productListSubject = BehaviorSubject<ProductApiResult>();
    _cartSubject = BehaviorSubject<Cart>.seeded(const Cart.empty());
    fetchProducts();
  }

  void fetchProducts() async {
    updateProductApiResult(ProductApiResultLoading());

    final result = await _backend.getAllProducts();
    updateProductApiResult(result);
  }

  void updateProductApiResult(ProductApiResult newResult) {
    _productListSubject.add(newResult);
  }

  Future<Product?> getProductFromId(String productId) async {
    final product = await _backend.getProductFromId(productId);
    return product;
  }

  // int cartProductQuantity() {
  //   int quantity = 0;
  //   for (var item in cart.cartItems) {
  //     quantity += item.quantity;
  //   }
  //   return quantity;
  // }

  // double calculateCartTotalAmount() {
  //   double amount = 0.0;
  //   for (var item in cart.cartItems) {
  //     amount += (int.parse(item.product.price) * item.quantity);
  //   }
  //   return amount;
  // }

  // void addProductToCart(Product product) {
  //   final prevCartItems = cart.cartItems;

  //   final itemIndexInCart = prevCartItems.indexWhere(
  //     (element) => element.product.id == product.id,
  //   );

  //   late CartItem newItem;

  //   if (itemIndexInCart != -1) {
  //     var previtem = prevCartItems[itemIndexInCart];
  //     prevCartItems[itemIndexInCart] =
  //         previtem.copyWith(quantity: previtem.quantity + 1);
  //   } else {
  //     newItem = CartItem(product: product, quantity: 1);
  //     cart.cartItems.add(newItem);
  //   }
  //   updateCart(cart);
  // }

  // void removeProductFromCart(Product product) {
  //   final prevCartItems = cart.cartItems;

  //   final itemIndexInCart = prevCartItems.indexWhere(
  //     (element) => element.product.id == product.id,
  //   );

  //   if (itemIndexInCart != -1) {
  //     var previtem = prevCartItems[itemIndexInCart];
  //     if (previtem.quantity > 1) {
  //       prevCartItems[itemIndexInCart] =
  //           previtem.copyWith(quantity: previtem.quantity - 1);
  //     } else {
  //       cart.cartItems.removeWhere(
  //         (element) => element.product.id == product.id,
  //       );
  //     }
  //     updateCart(cart);
  //   } else {
  //     // do nothing
  //     // hard to reach
  //   }
  // }

  // void clearCart() {
  //   updateCart(Cart.empty());
  // }

  // updateCart(Cart updatedCart) {
  //   _cartSubject.add(updatedCart);
  // }

  void dispose() {
    _productListSubject.close();
    _cartSubject.close();
  }
}

import 'package:flutter_ecommerce_project/backend/backend.dart';
import 'package:flutter_ecommerce_project/views/cart_view.dart';
import 'package:flutter_ecommerce_project/views/product_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backendProvider = Provider(((ref) => Backend()));

final productViewProvider = Provider(((ref) => ProductView(
      backend: ref.watch(backendProvider),
    )));

final cartViewProvider = Provider(((ref) => CartView()));

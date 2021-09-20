import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/model/product.model.dart';

class CartAddAction {
  final Product product;
  final String size;
  CartAddAction({required this.product, required this.size});
}

class CartSubAction {
  final Product product;
  final String size;
  CartSubAction({required this.product, required this.size});
}

class CartRemoveAction {
  final CartItem product;
  final String size;
  CartRemoveAction({required this.product, required this.size});
}

class CartClearAction {}

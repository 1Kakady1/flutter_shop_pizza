import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/model/product.model.dart';

class CartAddAction {
  final Product? product;
  final CartItem? cartItem;
  final String size;
  CartAddAction({this.product, this.cartItem, required this.size});
}

class CartSubAction {
  final Product? product;
  final CartItem? cartItem;
  final String size;
  CartSubAction({this.product, this.cartItem, required this.size});
}

class CartRemoveAction {
  final CartItem product;
  final String size;
  CartRemoveAction({required this.product, required this.size});
}

class CartChangeCommentsAction {
  final String? comments;
  final String id;
  final String size;
  CartChangeCommentsAction(
      {this.comments, required this.id, required this.size});
}

class CartClearAction {}

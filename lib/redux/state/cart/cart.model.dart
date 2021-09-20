import 'package:pizza_time/model/cart.model.dart';

class CartModelState {
  final List<CartItem> products;

  CartModelState({required this.products});

  factory CartModelState.initial() => CartModelState(products: []);

  CartModelState copyWith({List<CartItem>? products}) {
    return CartModelState(products: products ?? this.products);
  }
}

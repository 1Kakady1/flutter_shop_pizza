import 'package:pizza_time/model/cart.model.dart';

enum CountType {
  productCount,
  cartCount,
  fullCount,
}

int getCounter(List<CartItem> cart, CountType count) {
  int counter = 0;
  final cartLen = cart.length;

  switch (count) {
    case CountType.productCount:
      for (int i = 0; i < cartLen; i++) {
        counter += cart[i].count;
      }
      break;
    case CountType.cartCount:
      counter = cartLen;
      break;
    case CountType.fullCount:
      counter = -1;
      break;
  }

  return counter;
}

double getTotalPrice(List<CartItem> cart) {
  double totalPrice = 0;
  cart.forEach((item) => {
        if (item.price is int || item.price is double)
          {totalPrice += item.price * item.count}
        else
          {totalPrice += item.price[item.productSize] * item.count}
      });

  return totalPrice;
}

import 'dart:developer';

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
  for (int i = 0; i < cart.length; i++) {
    if (cart[i].price is int || cart[i].price is double) {
      totalPrice += cart[i].price * cart[i].count;
    } else {
      totalPrice += cart[i].price[cart[i].productSize] * cart[i].count;
    }
  }

  return totalPrice;
}

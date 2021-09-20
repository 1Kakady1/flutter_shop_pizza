import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/redux/state/cart/cart.action.dart';
import 'package:pizza_time/redux/state/cart/cart.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/cart/button_cart.dart';
import 'package:redux/redux.dart';

import 'button_cart.model.dart';

class ButtonCartContainer extends StatelessWidget implements ButtonCartProps {
  final Color? iconColor;
  final BoxDecoration? decoration;
  final double? width;
  final double? height;
  const ButtonCartContainer(
      {Key? key,
      this.iconColor = AppColors.write,
      this.decoration,
      this.height,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          child: StoreConnector<AppState, _ViewCartBtn>(
              distinct: true,
              converter: (store) => _ViewCartBtn.fromStore(store),
              builder: (context, vm) {
                return ButtonCart(
                  onPress: () => vm.onPress(),
                  counter: vm.counter,
                  iconColor: iconColor,
                  decoration: decoration,
                  width: width,
                  height: height,
                );
              }));
    });
  }
}

typedef GotoProducts = void Function(String cat, BuildContext context);

class _ViewCartBtn {
  final List<CartItem> products;
  final int counter;
  final Function onPress;
  _ViewCartBtn(
      {required this.products, required this.counter, required this.onPress});

  bool operator ==(other) {
    return (other is _ViewCartBtn) &&
        (this.products == other.products) &&
        (this.counter == other.counter);
  }

  @override
  int get hashCode {
    return products.hashCode + counter.hashCode;
  }

  static _ViewCartBtn fromStore(Store<AppState> store) {
    return _ViewCartBtn(
        products: CartSelectors.products(store.state),
        counter: CartSelectors.cartCount(store.state),
        onPress: () => 0);
  }
}

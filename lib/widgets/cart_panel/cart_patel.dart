import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/helpers/const.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/redux/state/cart/cart.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/routes/routes.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';
import 'package:redux/redux.dart';

class CartPanel extends StatelessWidget {
  final double? height;
  const CartPanel({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewCartPanel>(
        distinct: true,
        converter: (store) => _ViewCartPanel.fromStore(store),
        builder: (context, vm) {
          return Container(
              decoration: BoxDecoration(
                color: AppColors.write,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: double.infinity,
              height: height ?? 320,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Item Total"),
                      Text(
                        "\$ ${vm.totalPrice}",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Delivery Charge"),
                      Text(
                        "\$ ${AppConst.DELIVERY}",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        "\$ ${vm.totalPrice + AppConst.DELIVERY}",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonDefault(
                      decoration: BoxDecoration(
                          color: AppColors.red[200],
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      borderRadiusInlWell:
                          BorderRadius.all(Radius.circular(12)),
                      onPress: () =>
                          Navigator.popAndPushNamed(context, PathRoute.order),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20.0),
                        child: Text(
                          "Proceed to payment method",
                          style: TextStyle(color: AppColors.write),
                        ),
                      )),
                ],
              ));
        });
  }
}

class _ViewCartPanel {
  final List<CartItem> products;
  final int cartCount;
  final double totalPrice;
  _ViewCartPanel({
    required this.products,
    required this.cartCount,
    required this.totalPrice,
  });

  bool operator ==(other) {
    return (other is _ViewCartPanel) &&
        (this.products == other.products) &&
        (this.totalPrice == other.totalPrice) &&
        (this.cartCount == other.cartCount);
  }

  @override
  int get hashCode {
    return products.hashCode + totalPrice.hashCode + cartCount.hashCode;
  }

  static _ViewCartPanel fromStore(Store<AppState> store) {
    return _ViewCartPanel(
      products: CartSelectors.products(store.state),
      cartCount: CartSelectors.cartCount(store.state),
      totalPrice: CartSelectors.totalPrice(store.state),
    );
  }
}

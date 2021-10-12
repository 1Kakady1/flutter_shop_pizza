import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/helpers/product.utils.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/state/product/product.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/routes/routes.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';
import 'package:redux/redux.dart';

class ProductPanel extends StatelessWidget {
  final double? height;
  const ProductPanel({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewProductPanel>(
        distinct: true,
        converter: (store) => _ViewProductPanel.fromStore(store),
        builder: (context, vm) {
          final double price = vm.isLoad
              ? 0
              : getPrice(
                  price: vm.product!.price,
                  filtersSize: vm.product?.filter?.size,
                  size: vm.size);
          return Container(
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            width: double.infinity,
            height: height ?? 74,
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity:
                      vm.product == null || vm.error != "" || vm.isLoad == true
                          ? 0.0
                          : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(FlutterI18n.translate(context, "price_label"),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 16)),
                      SizedBox(
                        height: 6,
                      ),
                      Text("\$ ${price.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 24))
                    ],
                  ),
                ),
                ButtonDefault(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 19),
                    child: Row(
                      children: [
                        Text(
                          "Go to Cart",
                          style: TextStyle(
                              color: AppColors.write,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  onPress: () => Navigator.pushNamed(context, PathRoute.cart),
                  decoration: BoxDecoration(
                      color: AppColors.red[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )
              ],
            ),
          );
        });
  }
}

class _ViewProductPanel {
  final Product? product;
  final bool isLoad;
  final String size;
  final String error;
  _ViewProductPanel(
      {required this.product,
      required this.isLoad,
      required this.size,
      required this.error});

  bool operator ==(other) {
    return (other is _ViewProductPanel) &&
        (this.product == other.product) &&
        (this.isLoad == other.isLoad) &&
        (this.size == other.size) &&
        (this.error == other.error);
  }

  @override
  int get hashCode {
    return product.hashCode + size.hashCode + isLoad.hashCode + error.hashCode;
  }

  static _ViewProductPanel fromStore(Store<AppState> store) {
    final size = ProductSelectors.size(store.state);
    return _ViewProductPanel(
      product: ProductSelectors.products(store.state),
      isLoad: ProductSelectors.isLoad(store.state),
      error: ProductSelectors.error(store.state),
      size: size,
    );
  }
}

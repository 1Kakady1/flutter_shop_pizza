import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/state/category/category.selector.dart';
import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/state/home/home.selector.dart';
import 'package:pizza_time/redux/state/products/products.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/popular/popular.dart';
import 'package:redux/redux.dart';

class PopularContainer extends StatelessWidget {
  const PopularContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          child: StoreConnector<AppState, _ViewPopular>(
              onInit: (store) => store.dispatch(getHome(
                  field: "cat",
                  value: "all",
                  where: CallectionWhere.arrayContainsIsEqualToTop,
                  limit: 3)),
              converter: (store) => _ViewPopular.fromStore(store),
              builder: (context, vm) {
                return PopularList(
                    isLoad: vm.isLoad,
                    products: vm.products,
                    cat: vm.cat,
                    constraintsMaxWidth: constraints.maxWidth);
              }));
    });
  }
}

class _ViewPopular {
  final List<Product> products;
  final bool isLoad;
  final String cat;

  _ViewPopular(
      {required this.products, required this.isLoad, required this.cat});

  static _ViewPopular fromStore(Store<AppState> store) {
    return _ViewPopular(
        products: HomeSelectors.products(store.state),
        cat: CategorySelectors.currentCat(store.state),
        isLoad: HomeSelectors.isLoad(store.state));
  }
}

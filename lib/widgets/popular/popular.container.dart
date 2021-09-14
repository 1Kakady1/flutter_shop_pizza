import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/state/home/home.selector.dart';
import 'package:pizza_time/redux/state/products/products.actions.dart';
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
              distinct: true,
              converter: (store) => _ViewPopular.fromStore(store),
              builder: (context, vm) {
                return PopularList(
                    isLoad: vm.isLoad,
                    products: vm.products,
                    cat: vm.cat,
                    gotoProducts: vm.gotoProducts,
                    constraintsMaxWidth: constraints.maxWidth);
              }));
    });
  }
}

typedef GotoProducts = void Function(String cat, BuildContext context);

class _ViewPopular {
  final List<Product> products;
  final bool isLoad;
  final String cat;
  final GotoProducts gotoProducts;
  _ViewPopular(
      {required this.products,
      required this.isLoad,
      required this.cat,
      required this.gotoProducts});

  bool operator ==(other) {
    return (other is _ViewPopular) &&
        (this.products == other.products) &&
        (this.isLoad == other.isLoad) &&
        (this.cat == other.cat);
  }

  @override
  int get hashCode {
    return products.hashCode + cat.hashCode + isLoad.hashCode;
  }

  static _ViewPopular fromStore(Store<AppState> store) {
    return _ViewPopular(
        products: HomeSelectors.products(store.state),
        cat: HomeSelectors.currentCat(store.state),
        isLoad: HomeSelectors.isLoad(store.state),
        gotoProducts: (String cat, BuildContext context) {
          store.dispatch(
              GotoCategoryProducts(cat: cat, error: "", isLoad: true));
          Navigator.pushNamed(context, "/products");
        });
  }
}

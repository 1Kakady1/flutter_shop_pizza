import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/state/category/category.selector.dart';
import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/state/products/products.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/card/card_product_small/card_product_small.dart';
import 'package:redux/redux.dart';

class ProductSliverContainer extends StatelessWidget {
  const ProductSliverContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewProductsListSliver>(
            onInit: (store) => {
                  if (store.state.products.products.length == 0)
                    {
                      store.dispatch(getProducts(
                          field: "cat",
                          where: CallectionWhere.arrayContains,
                          value: store.state.category.currentCat))
                    }
                },
            converter: (store) => _ViewProductsListSliver.fromStore(store),
            builder: (context, vm) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CardProductSmall(
                          product: vm.product[index],
                          onPress: () => {
                                Navigator.pushNamed(context, "/product",
                                    arguments: {
                                      "id": vm.product[index].id,
                                      "product": vm.product[index]
                                    })
                              }),
                    );
                  },
                  childCount: vm.product.length,
                ),
              );
            }));
  }
}

class _ViewProductsListSliver {
  final String currentCat;
  final int catIndex;
  final List<Product> product;

  _ViewProductsListSliver({
    required this.currentCat,
    required this.catIndex,
    required this.product,
  });

  static _ViewProductsListSliver fromStore(Store<AppState> store) {
    final curCat = CategorySelectors.currentCat(store.state);
    return _ViewProductsListSliver(
        product: ProductsSelectors.products(store.state),
        currentCat: curCat,
        catIndex: CategorySelectors.catIndex(curCat)(store.state));
  }
}

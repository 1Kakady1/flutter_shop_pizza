import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/state/category/category.selector.dart';
import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/state/products/products.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/routes/routes.dart';
import 'package:pizza_time/styles/colors.dart';
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
                    return _productsContent(
                        vm.product, vm.isLoad, vm.error, context, index);
                  },
                  childCount: vm.isLoad == true || vm.error != ""
                      ? 1
                      : vm.product.length,
                ),
              );
            }));
  }
}

Widget _containerFull(List<Widget> wd, BuildContext ctx) {
  return Container(
    height: MediaQuery.of(ctx).size.height - 130,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: wd,
    ),
  );
}

Widget _productsContent(List<Product> products, bool isLoad, String error,
    BuildContext context, int index) {
  if (isLoad == false && error == "" && products.length > 0) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CardProductSmall(
          product: products[index],
          onPress: () => {
                Navigator.pushNamed(context, PathRoute.product, arguments: {
                  "id": products[index].id,
                  "product": products[index]
                })
              }),
    );
  }
  if (isLoad == true) {
    return _containerFull([
      Center(
        child: new CircularProgressIndicator(
          color: AppColors.red[200],
        ),
      ),
    ], context);
  }

  if (error != "") {
    return _containerFull([
      Center(
          child: Image.asset(
        "assets/img/error.png",
        width: 325,
        height: 161,
      )),
      Center(
        child: Text("Error: $error"),
      ),
    ], context);
  }
  return _containerFull([
    Center(
        child: Image.asset(
      "assets/img/error-404.png",
      width: 325,
      height: 161,
    )),
    Center(
      child: Text(FlutterI18n.translate(context, "not_found")),
    ),
  ], context);
}

class _ViewProductsListSliver {
  final String currentCat;
  final int catIndex;
  final List<Product> product;
  final String error;
  final bool isLoad;
  _ViewProductsListSliver(
      {required this.currentCat,
      required this.catIndex,
      required this.product,
      required this.isLoad,
      required this.error});

  static _ViewProductsListSliver fromStore(Store<AppState> store) {
    final curCat = CategorySelectors.currentCat(store.state);
    return _ViewProductsListSliver(
        product: ProductsSelectors.products(store.state),
        currentCat: curCat,
        error: ProductsSelectors.error(store.state),
        isLoad: ProductsSelectors.isLoad(store.state),
        catIndex: CategorySelectors.catIndex(curCat)(store.state));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/redux/state/category/category.actions.dart';
import 'package:pizza_time/redux/state/category/category.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/appbar/appbar_sliver_product/appbar_sliver_product.dart';
import 'package:redux/redux.dart';

class AppbarSliverProductContainer extends StatelessWidget {
  const AppbarSliverProductContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewAppbarSliverProduct>(
            //onInit: (store) => store.dispatch(getCategorys(store)),
            converter: (store) => _ViewAppbarSliverProduct.fromStore(store),
            builder: (context, vm) {
              return AppbarSliverProduct(
                  cat: vm.cat,
                  activeCat: vm.catIndex,
                  onPress: (String cat) {
                    vm.changeCat(cat);
                  });
            }));
  }
}

typedef ChangeCat = void Function(String cat);

class _ViewAppbarSliverProduct {
  final String currentCat;
  final int catIndex;
  final List<Category> cat;
  final ChangeCat changeCat;
  _ViewAppbarSliverProduct(
      {required this.currentCat,
      required this.catIndex,
      required this.cat,
      required this.changeCat});

  static _ViewAppbarSliverProduct fromStore(Store<AppState> store) {
    final curCat = CategorySelectors.currentCat(store.state);
    return _ViewAppbarSliverProduct(
        cat: CategorySelectors.categorys(store.state),
        currentCat: curCat,
        catIndex: CategorySelectors.catIndex(curCat)(store.state),
        changeCat: (String cat) =>
            store.dispatch(ChangeCategorysSliverAction(currentCat: cat)));
  }
}

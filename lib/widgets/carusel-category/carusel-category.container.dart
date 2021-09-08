import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/redux/state/category/category.actions.dart';
import 'package:pizza_time/redux/state/category/category.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/carusel-category/carusel-category.dart';
import 'package:redux/redux.dart';

class CaruselCategoryContainer extends StatelessWidget {
  const CaruselCategoryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewCaruselCategory>(
            onInit: (store) => store.dispatch(getCategorys(store)),
            converter: (store) => _ViewCaruselCategory.fromStore(store),
            builder: (context, vm) {
              return CaruselCategory(
                  cat: vm.cat,
                  activeCat: vm.catIndex,
                  onPress: (String cat) {
                    vm.changeCat(cat);
                  });
            }));
  }
}

typedef ChangeCat = void Function(String cat);

class _ViewCaruselCategory {
  final String currentCat;
  final int catIndex;
  final List<Category> cat;
  final ChangeCat changeCat;
  _ViewCaruselCategory(
      {required this.currentCat,
      required this.catIndex,
      required this.cat,
      required this.changeCat});

  static _ViewCaruselCategory fromStore(Store<AppState> store) {
    final curCat = CategorySelectors.currentCat(store.state);
    return _ViewCaruselCategory(
        cat: CategorySelectors.categorys(store.state),
        currentCat: curCat,
        catIndex: CategorySelectors.catIndex(curCat)(store.state),
        changeCat: (String cat) =>
            store.dispatch(ChangeCategorysAction(currentCat: cat)));
  }
}

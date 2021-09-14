import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/state/home/home.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/carusel-category/carusel-category.dart';
import 'package:redux/redux.dart';

class CaruselCategoryHomeContainer extends StatelessWidget {
  const CaruselCategoryHomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewCaruselHomeCategory>(
            distinct: true,
            converter: (store) => _ViewCaruselHomeCategory.fromStore(store),
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

class _ViewCaruselHomeCategory {
  final String currentCat;
  final int catIndex;
  final List<Category> cat;
  final ChangeCat changeCat;
  final bool isLoad;
  _ViewCaruselHomeCategory(
      {required this.currentCat,
      required this.catIndex,
      required this.cat,
      required this.changeCat,
      required this.isLoad});

  bool operator ==(other) {
    return (other is _ViewCaruselHomeCategory) &&
        (this.currentCat == other.currentCat) &&
        (this.catIndex == other.catIndex) &&
        (this.cat == other.cat) &&
        (this.isLoad == other.isLoad);
  }

  @override
  int get hashCode {
    return catIndex.hashCode +
        cat.hashCode +
        isLoad.hashCode +
        currentCat.hashCode;
  }

  static _ViewCaruselHomeCategory fromStore(Store<AppState> store) {
    final curCat = HomeSelectors.currentCat(store.state);
    return _ViewCaruselHomeCategory(
        isLoad: HomeSelectors.isLoad(store.state),
        cat: HomeSelectors.categorys(store.state),
        currentCat: curCat,
        catIndex: HomeSelectors.catIndex(curCat)(store.state),
        changeCat: (String cat) =>
            store.dispatch(ChangeHomeCategorysAction(currentCat: cat)));
  }
}

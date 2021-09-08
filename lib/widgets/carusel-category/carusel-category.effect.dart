import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/redux/state/category/category.actions.dart';
import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final _api = Api();

Stream<dynamic> changeCatHomeEpic(
  Stream<dynamic> actions,
  EpicStore<AppState> store,
) {
  return actions.whereType<ChangeCategorysAction>().switchMap((action) {
    SetProductsAction(products: [], error: "", isLoad: true);
    return Stream.fromFuture(_api
        .getProducts(
            limit: 3,
            field: "cat",
            where: CallectionWhere.arrayContainsIsEqualToTop,
            value: action.currentCat)
        .then((results) => ChangeProductsHomeAction(
            products: results, error: "", isLoad: false))
        .catchError((error) =>
            ChangeProductsHomeAction(products: [], error: "", isLoad: false)));
  });
}

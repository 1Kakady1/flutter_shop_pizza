import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/redux/state/category/category.actions.dart';
import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final _api = Api();

Stream<dynamic> changeProductsTheCategory(
  Stream<dynamic> actions,
  EpicStore<AppState> store,
) {
  return actions.whereType<ChangeCategorysSliverAction>().switchMap((
    action,
  ) {
    return Stream.fromFuture(_api.getProductsRequest(
            field: "cat",
            where: CallectionWhere.arrayContains,
            value: action.currentCat))
        .expand((element) {
      final data = element.data;
      if (element.error == "") {
        return [
          RequestProductsSuccessAction(
              products: data, error: "", isLoad: false),
        ];
      }
      return [RequestProductsErrorAction(isLoad: false, error: element.error)];
    });
  });
}

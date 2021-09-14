import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/redux/state/category/category.actions.dart';
import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final _api = Api();

Stream<dynamic> getHomeContnent(
  Stream<dynamic> actions,
  EpicStore<AppState> store,
) {
  return actions.whereType<RequestHome>().switchMap((
    action,
  ) {
    return Stream.fromFuture(_api.getHome(
            limit: 4,
            field: "cat",
            where: CallectionWhere.arrayContainsIsEqualToTop,
            value: action.cat ?? "all"))
        .expand((element) {
      final data = element.data;
      if (element.error == "" && data != null) {
        return [
          RequestHomeSuccess(
              products: data.products, error: "", isLoad: false, cat: data.cat),
          SetCategorysAction(categorys: data.cat, isLoad: false, error: "")
        ];
      }
      return [RequestHomeError(isLoad: false, error: element.error)];
    });
  });
}

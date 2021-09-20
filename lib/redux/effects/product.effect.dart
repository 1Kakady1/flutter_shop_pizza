import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/redux/state/product/product.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final _api = Api();

Stream<dynamic> effectGetProductByID(
  Stream<dynamic> actions,
  EpicStore<AppState> store,
) {
  return actions.whereType<RequestProductAction>().switchMap((
    action,
  ) {
    return Stream.fromFuture(_api.getProductById(action.id)).expand((element) {
      final data = element.data;
      if (element.error == "") {
        final String size = data?.filter?.size?[0] ?? "";
        return [
          RequestProductSuccessAction(
              products: data, error: "", isLoad: false, size: size),
        ];
      }
      return [RequestProductErrorAction(isLoad: false, error: element.error)];
    });
  });
}

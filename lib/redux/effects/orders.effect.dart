import 'dart:developer';

import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/redux/state/history/history.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final _api = Api();

Stream<dynamic> effectGetUserOrders(
  Stream<dynamic> actions,
  EpicStore<AppState> store,
) {
  return actions.whereType<RequestHistoryAction>().switchMap((
    action,
  ) {
    return Stream.fromFuture(
            _api.getOrdersByUsertId(action.id, 2, action.offset))
        .expand((element) {
      final data = element.data;
      log("effect ${element.offset}");
      if (element.error == "") {
        return [
          RequestHistorySuccessAction(
              history: data ?? [],
              error: "",
              isLoad: false,
              offset: element.offset),
        ];
      }
      return [
        RequestHistoryErrorAction(
            isLoad: false, error: element.error, offset: null)
      ];
    });
  });
}

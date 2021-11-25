import 'dart:developer';

import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/redux/state/user/user.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final _api = Api();

Stream<dynamic> setUserEffect(
  Stream<dynamic> actions,
  EpicStore<AppState> store,
) {
  return actions.whereType<UserRequestAction>().switchMap((
    action,
  ) {
    return Stream.fromFuture(_api.getUser(action.id, action.email ?? ""))
        .expand((element) {
      final data = element.data;
      if (element.error == "" && data != null) {
        return [
          UserRequestSuccessAction(
              user: data, error: "", isLoad: false, isAuth: true),
        ];
      }
      return [UserRequestErrorAction(isLoad: false, error: element.error)];
    });
  });
}

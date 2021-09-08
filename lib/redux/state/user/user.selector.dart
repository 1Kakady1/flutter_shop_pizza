import 'package:pizza_time/redux/state/user/user.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:reselect/reselect.dart';

class UserSelectors {
  static final user = createSelector1(
    AppSelectors.userSelector,
    (UserModelState user) => user.info,
  );

  static final isAuth = createSelector1(
    AppSelectors.userSelector,
    (UserModelState user) => user.isAuth,
  );

  static final toUser = createSelector1(
    AppSelectors.userSelector,
    (UserModelState user) => user,
  );
}

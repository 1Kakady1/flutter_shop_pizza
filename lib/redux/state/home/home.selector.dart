import 'package:pizza_time/redux/state/home/home.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:reselect/reselect.dart';

class HomeSelectors {
  static final products = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home.products,
  );

  static final isLoad = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home.isLoad,
  );

  static final cat = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home.cat,
  );

  static final error = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home.error,
  );

  static final toProducts = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home,
  );
}

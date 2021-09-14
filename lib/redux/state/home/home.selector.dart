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

  static final categorys = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home.cat,
  );

  static final error = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home.error,
  );

  static final currentCat = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home.currentCat,
  );

  static final catIndex = (String name) => createSelector1(
        AppSelectors.homeSelector,
        (HomeModelState home) => home.cat.indexWhere(
            (element) => element.name.toLowerCase() == name.toLowerCase()),
      );
  static final catIndexByID = (String id) => createSelector1(
        AppSelectors.homeSelector,
        (HomeModelState home) => home.cat.indexWhere(
            (element) => element.catId.toLowerCase() == id.toLowerCase()),
      );

  static final toHome = createSelector1(
    AppSelectors.homeSelector,
    (HomeModelState home) => home,
  );
}

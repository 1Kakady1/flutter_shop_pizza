import 'package:pizza_time/redux/state/category/category.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:reselect/reselect.dart';

class CategorySelectors {
  static final categorys = createSelector1(
    AppSelectors.categorySelector,
    (CategoryModelState category) => category.categorys,
  );

  static final isLoad = createSelector1(
    AppSelectors.categorySelector,
    (CategoryModelState category) => category.isLoad,
  );

  static final error = createSelector1(
    AppSelectors.categorySelector,
    (CategoryModelState category) => category.error,
  );

  static final currentCat = createSelector1(
    AppSelectors.categorySelector,
    (CategoryModelState category) => category.currentCat,
  );

  static final catIndex = (String name) => createSelector1(
        AppSelectors.categorySelector,
        (CategoryModelState category) => category.categorys.indexWhere(
            (element) => element.name.toLowerCase() == name.toLowerCase()),
      );
  static final catIndexByID = (String id) => createSelector1(
        AppSelectors.categorySelector,
        (CategoryModelState category) => category.categorys.indexWhere(
            (element) => element.catId.toLowerCase() == id.toLowerCase()),
      );

  static final toCategory = createSelector1(
    AppSelectors.categorySelector,
    (CategoryModelState category) => category,
  );
}

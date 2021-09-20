import 'package:pizza_time/redux/state/product/product.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:reselect/reselect.dart';

class ProductSelectors {
  static final products = createSelector1(
    AppSelectors.productSelector,
    (ProductModelState product) => product.product,
  );

  static final isLoad = createSelector1(
    AppSelectors.productSelector,
    (ProductModelState product) => product.isLoad,
  );

  static final error = createSelector1(
    AppSelectors.productSelector,
    (ProductModelState product) => product.error,
  );

  static final size = createSelector1(
    AppSelectors.productSelector,
    (ProductModelState product) => product.size,
  );

  static final toProducts = createSelector1(
    AppSelectors.productSelector,
    (ProductModelState product) => product,
  );
}

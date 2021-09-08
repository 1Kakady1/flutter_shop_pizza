import 'package:pizza_time/redux/state/products/products.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:reselect/reselect.dart';

class ProductsSelectors {
  static final products = createSelector1(
    AppSelectors.productsSelector,
    (Products products) => products.products,
  );

  static final isLoad = createSelector1(
    AppSelectors.productsSelector,
    (Products products) => products.isLoad,
  );

  static final error = createSelector1(
    AppSelectors.productsSelector,
    (Products products) => products.error,
  );

  static final toProducts = createSelector1(
    AppSelectors.productsSelector,
    (Products products) => products,
  );
}

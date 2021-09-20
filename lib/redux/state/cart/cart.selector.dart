import 'package:pizza_time/helpers/cart.utils.dart';
import 'package:pizza_time/redux/state/cart/cart.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:reselect/reselect.dart';

class CartSelectors {
  static final products = createSelector1(
    AppSelectors.cartSelector,
    (CartModelState cart) => cart.products,
  );

  static final cartCount = createSelector1(
    AppSelectors.cartSelector,
    (CartModelState cart) => getCounter(cart.products, CountType.productCount),
  );

  static final getCartProductIndex =
      (String id, String size) => createSelector1(
            AppSelectors.cartSelector,
            (CartModelState cart) => cart.products.indexWhere(
                (element) => element.id == id && element.productSize == size),
          );

  static final totalPrice = createSelector1(
    AppSelectors.cartSelector,
    (CartModelState cart) => getTotalPrice(cart.products),
  );

  static final toCart = createSelector1(
    AppSelectors.cartSelector,
    (CartModelState cart) => cart,
  );
}

import 'package:pizza_time/redux/epics.dart';
import 'package:pizza_time/redux/state/cart/cart.model.dart';
import 'package:pizza_time/redux/state/cart/cart.reducer.dart';
import 'package:pizza_time/redux/state/category/category.model.dart';
import 'package:pizza_time/redux/state/category/category.reducer.dart';
import 'package:pizza_time/redux/state/history/history.model.dart';
import 'package:pizza_time/redux/state/history/history.reducer.dart';
import 'package:pizza_time/redux/state/home/home.model.dart';
import 'package:pizza_time/redux/state/home/home.reducer.dart';
import 'package:pizza_time/redux/state/product/product.model.dart';
import 'package:pizza_time/redux/state/product/product.reducer.dart';
import 'package:pizza_time/redux/state/products/products.model.dart';
import 'package:pizza_time/redux/state/products/products.reducer.dart';
import 'package:pizza_time/redux/state/user/user.model.dart';
import 'package:pizza_time/redux/state/user/user.reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class AppState {
  final UserModelState user;
  final Products products;
  final CategoryModelState category;
  final HomeModelState home;
  final CartModelState cart;
  final ProductModelState product;
  final HistoryModelState history;
  AppState(
      {required this.user,
      required this.products,
      required this.category,
      required this.home,
      required this.cart,
      required this.product,
      required this.history});

  AppState copyWith({user, products, category, home, cart, product, history}) {
    return AppState(
        user: user ?? this.user,
        products: products ?? this.products,
        category: category ?? this.category,
        home: home ?? this.home,
        cart: cart ?? this.cart,
        product: product ?? this.product,
        history: history ?? this.history);
  }
}

var _epicMiddleware = new EpicMiddleware(epic);

AppState _reducer(AppState state, dynamic action) => AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action),
    product: productReducer(state.product, action),
    category: categorysReducer(state.category, action),
    home: homeReducer(state.home, action),
    cart: cartReducer(state.cart, action),
    history: historyReducer(state.history, action));

AppState _state = AppState(
  home: HomeModelState.initial(),
  user: UserModelState.initial(),
  products: Products.initial(),
  category: CategoryModelState.initial(),
  cart: CartModelState.initial(),
  product: ProductModelState.initial(),
  history: HistoryModelState.initial(),
);

Store<AppState> storeApp = Store(_reducer,
    middleware: [new LoggingMiddleware.printer(), _epicMiddleware],
    initialState: _state);

final storeAppDev =
    DevToolsStore(_reducer, initialState: _state, middleware: []);

class AppSelectors {
  static AppState appSelector(AppState state) => state;
  static Products productsSelector(AppState state) => state.products;
  static ProductModelState productSelector(AppState state) => state.product;
  static UserModelState userSelector(AppState state) => state.user;
  static CategoryModelState categorySelector(AppState state) => state.category;
  static HomeModelState homeSelector(AppState state) => state.home;
  static CartModelState cartSelector(AppState state) => state.cart.copyWith();
  static HistoryModelState historySelector(AppState state) => state.history;
}

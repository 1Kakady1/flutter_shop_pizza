import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Api _api = Api();

class SetHomeAction {
  List<Product> products;
  final List<Category> cat;
  bool isLoad;
  String error;

  SetHomeAction(
      {required this.products,
      required this.error,
      required this.isLoad,
      required this.cat});
}

class SetHomeCatAction {
  bool isLoad;
  String error;
  final List<Category> cat;
  SetHomeCatAction({
    required this.cat,
    required this.error,
    required this.isLoad,
  });
}

class ChangeProductsHomeAction {
  final bool isLoad;
  final String error;
  List<Product> products;
  ChangeProductsHomeAction(
      {required this.error, required this.isLoad, required this.products});
}

ThunkAction<AppState> getHome(
    {int limit = 10, String? field, CallectionWhere? where, dynamic value}) {
  return (Store<AppState> store) async {
    _api
        .getHome(limit: limit, where: where, field: field, value: value)
        .then((value) {
      return store.dispatch(SetHomeAction(
          products: value.products, cat: value.cat, error: "", isLoad: false));
    }).catchError((e) => store.dispatch(SetHomeAction(
            products: [], cat: [], error: e.toString(), isLoad: false)));
  };
}

import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Api _api = Api();

class RequestProductsAction {
  bool isLoad;
  String error;

  RequestProductsAction({required this.error, required this.isLoad});
}

class RequestProductsSuccessAction {
  List<Product> products;
  bool isLoad;
  String error;

  RequestProductsSuccessAction(
      {required this.products, required this.error, required this.isLoad});
}

class RequestProductsErrorAction {
  bool isLoad;
  String error;

  RequestProductsErrorAction({required this.error, required this.isLoad});
}

class GotoCategoryProducts {
  final String? cat;
  bool isLoad;
  String error;
  GotoCategoryProducts({this.cat, required this.isLoad, required this.error});
}

class SetProductsAction {
  List<Product> products;
  bool isLoad;
  String error;

  SetProductsAction(
      {required this.products, required this.error, required this.isLoad});
}

ThunkAction<AppState> getProducts(
    {int limit = 10, String? field, CallectionWhere? where, dynamic value}) {
  return (Store<AppState> store) async {
    _api
        .getProducts(limit: limit, where: where, field: field, value: value)
        .then((value) {
      return store.dispatch(
          SetProductsAction(products: value, error: "", isLoad: false));
    }).catchError((e) => store.dispatch(SetProductsAction(
            products: [], error: e.toString(), isLoad: false)));
  };
}

// ThunkAction getProducts = (Store store,
//     {int limit = 10,
//     String? field,
//     CallectionWhere? where,
//     dynamic value}) async {
//   _api
//       .getProducts(limit: limit, where: where, field: field, value: value)
//       .then((value) {
//     return store
//         .dispatch(SetProductsAction(products: value, error: "", isLoad: false));
//   }).catchError((e) => store.dispatch(
//           SetProductsAction(products: [], error: e.toString(), isLoad: false)));
// };

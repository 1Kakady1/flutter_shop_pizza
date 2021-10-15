import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/product.model.dart';

class RequestProductsAction {
  bool isLoad;
  String error;
  String? field;
  CallectionWhere? where;
  String? value;
  RequestProductsAction(
      {required this.error,
      required this.isLoad,
      this.value,
      this.field,
      this.where});
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

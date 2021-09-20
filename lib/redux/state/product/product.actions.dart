import 'package:pizza_time/model/product.model.dart';

class RequestProductAction {
  bool isLoad;
  String error;
  String id;
  RequestProductAction(
      {required this.error, required this.isLoad, required this.id});
}

class RequestProductSuccessAction {
  Product? products;
  bool isLoad;
  String error;
  String size;

  RequestProductSuccessAction(
      {required this.products,
      required this.error,
      required this.isLoad,
      required this.size});
}

class RequestProductErrorAction {
  bool isLoad;
  String error;

  RequestProductErrorAction({required this.error, required this.isLoad});
}

class ChangeProductSize {
  final String size;

  ChangeProductSize(this.size);
}

class SetProductAction {
  List<Product> products;
  bool isLoad;
  String error;

  SetProductAction(
      {required this.products, required this.error, required this.isLoad});
}

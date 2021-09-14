import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/model/product.model.dart';

class RequestHomeSuccess {
  List<Product> products;
  final List<Category> cat;
  bool isLoad;
  String error;

  RequestHomeSuccess(
      {required this.products,
      required this.error,
      required this.isLoad,
      required this.cat});
}

class RequestHome {
  final bool isLoad;
  final String error;
  final String? cat;
  RequestHome({required this.isLoad, required this.error, this.cat});
}

class RequestHomeError {
  final bool isLoad;
  final String error;
  RequestHomeError({
    required this.isLoad,
    required this.error,
  });
}

class ChangeHomeCategorysAction {
  final String currentCat;
  ChangeHomeCategorysAction({required this.currentCat});
}

class ChangeProductsHomeAction {
  final bool isLoad;
  final String error;
  List<Product> products;
  ChangeProductsHomeAction(
      {required this.error, required this.isLoad, required this.products});
}

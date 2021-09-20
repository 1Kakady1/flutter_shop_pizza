import 'package:pizza_time/model/product.model.dart';

class ProductModelState {
  final Product? product;
  final bool isLoad;
  final String error;
  final String size;

  ProductModelState(
      {required this.product,
      required this.size,
      required this.isLoad,
      required this.error});

  factory ProductModelState.initial() =>
      ProductModelState(product: null, isLoad: true, error: "", size: "");

  ProductModelState copyWith({product, isLoad, error, size}) {
    return ProductModelState(
        product: product ?? this.product,
        isLoad: isLoad ?? this.isLoad,
        error: error ?? this.error,
        size: size ?? this.size);
  }
}

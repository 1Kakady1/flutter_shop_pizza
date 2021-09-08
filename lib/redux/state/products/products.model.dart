import 'package:pizza_time/model/product.model.dart';

class Products {
  final List<Product> products;
  final bool isLoad;
  final String error;

  Products({required this.products, required this.isLoad, required this.error});

  factory Products.initial() => Products(products: [], isLoad: true, error: "");

  Products copyWith({products, isLoad, error}) {
    return Products(
      products: products ?? this.products,
      isLoad: isLoad ?? this.isLoad,
      error: error ?? this.error,
    );
  }
}

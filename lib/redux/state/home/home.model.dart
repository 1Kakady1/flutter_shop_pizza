import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/model/product.model.dart';

class HomeModelState {
  final List<Product> products;
  final List<Category> cat;
  final bool isLoad;
  final String error;
  final String currentCat;

  HomeModelState(
      {required this.products,
      required this.cat,
      required this.isLoad,
      required this.error,
      required this.currentCat});

  factory HomeModelState.initial() => HomeModelState(
      products: [], cat: [], isLoad: true, error: "", currentCat: "all");

  HomeModelState copyWith({products, isLoad, error, cat, currentCat}) {
    return HomeModelState(
        products: products ?? this.products,
        isLoad: isLoad ?? this.isLoad,
        error: error ?? this.error,
        cat: cat ?? this.cat,
        currentCat: currentCat ?? this.currentCat);
  }
}

class HomeReduserModelSetHome {
  final List<Product> products;
  final List<Category> cat;
  HomeReduserModelSetHome({
    required this.products,
    required this.cat,
  });
}

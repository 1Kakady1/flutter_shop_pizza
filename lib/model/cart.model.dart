import 'package:pizza_time/model/product_filter.model.dart';

class CartItem {
  final String title;
  final String preview;
  final String id;
  final int count;
  final ProductFilter? filter;
  final dynamic price;
  final String? cat;
  final String? comments;
  final String productSize;

  CartItem(
      {required this.title,
      required this.preview,
      required this.id,
      required this.count,
      this.filter,
      this.price,
      this.cat,
      this.comments,
      required this.productSize});

  CartItem copyWith({
    title,
    preview,
    id,
    count,
    filter,
    price,
    cat,
    comments,
    productSize,
  }) {
    return CartItem(
      title: title ?? this.title,
      preview: preview ?? this.preview,
      id: id ?? this.id,
      count: count ?? this.count,
      filter: filter ?? this.filter,
      price: price ?? this.price,
      cat: cat ?? this.cat,
      comments: comments ?? this.comments,
      productSize: productSize ?? this.productSize,
    );
  }
}

class CartItemComments {
  final String id;
  final String size;
  final String comments;

  CartItemComments(
      {required this.id, required this.size, required this.comments});
}

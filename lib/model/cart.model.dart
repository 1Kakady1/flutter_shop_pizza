import 'package:pizza_time/model/product_filter.model.dart';

typedef ChangeCartItemCommentsType = void Function(
    String id, String size, String? comments);

class CartItem {
  late String title;
  String? preview;
  late String id;
  late int count;
  late ProductFilter? filter;
  late dynamic price;
  late String? cat;
  late String? comments;
  late String productSize;
  late bool? isUnit;

  CartItem(
      {required this.title,
      required this.preview,
      required this.id,
      required this.count,
      this.filter,
      this.price,
      this.cat,
      this.comments,
      this.isUnit,
      required this.productSize});

  @override
  String toString() {
    return 'CartItem: {name: ${title}, age: ${price}}';
  }

  CartItem.fromJson(Map<String, dynamic> json) {
    title = json["title"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    count = json["count"] ?? 0;
    filter = filter = (json["filters"] != null)
        ? ProductFilter.fromJson(json["filters"])
        : null;
    cat = json["cat"] ?? "";
    comments = json["comments"] ?? "";
    productSize = json["productSize"] ?? "";
    isUnit = json["isUnit"] ?? null;
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    if (filter != null) {
      data["filters"] = filter!.toJson();
    }
    data["count"] = count;
    data["price"] = price;
    // if (price is int || price is double) {
    //   data["price"] = price;
    // } else {
    //   data["price"] = price.toJson();
    // }

    data["isUnit"] = isUnit;
    data["preview"] = preview;
    data["title"] = title;
    data["productSize"] = productSize;
    return data;
  }

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
    isUnit,
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
        isUnit: isUnit ?? this.isUnit);
  }
}

class CartItemComments {
  final String id;
  final String size;
  final String comments;

  CartItemComments(
      {required this.id, required this.size, required this.comments});
}

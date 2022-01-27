import 'package:intl/intl.dart';
import 'package:pizza_time/model/cart.model.dart';

class OrderModel {
  late String? key;
  late String? id;
  late String name;
  late String email;
  late String date;
  late String? comments;
  late String address;
  late List<CartItem> products;
  late String? userID;

  OrderModel(
      {this.key,
      required this.name,
      required this.email,
      required this.date,
      this.comments,
      required this.address,
      required this.products,
      this.id,
      this.userID});

  OrderModel.fromJson(Map<String, dynamic> json) {
    key = json["key"] ?? "";
    name = json["name"] ?? "";
    email = json["email"] ?? "";
    address = json["address"] ?? "";
    comments = json["comments"] ?? "";
    id = json["id"] ?? "";
    final arr0 = <CartItem>[];
    if (json["products"] != null) {
      final v = json["products"];
      v.forEach((v) {
        arr0.add(CartItem.fromJson(v));
      });
    }
    products = arr0;
    date = DateFormat('dd.MM.yyyy  kk:mm').format(json["date"]).toString();
    userID = json["userID"] ?? "";
  }
}

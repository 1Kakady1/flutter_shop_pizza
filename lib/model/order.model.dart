import 'package:pizza_time/model/cart.model.dart';

class OrderModel {
  final String? key;
  final String name;
  final String email;
  final String date;
  final String? comments;
  final String address;
  final List<CartItem> products;
  final String? userID;

  OrderModel(
      {this.key,
      required this.name,
      required this.email,
      required this.date,
      this.comments,
      required this.address,
      required this.products,
      this.userID});
}

import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/cart/button_cart.model.dart';

typedef Press = void Function();

class ButtonCart extends StatelessWidget implements ButtonCartProps {
  final Press onPress;
  final double? iconSize;
  final Color? iconColor;
  final int counter;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  ButtonCart(
      {required this.onPress,
      required this.counter,
      this.iconSize = 24.0,
      this.iconColor = AppColors.black,
      this.height,
      this.width,
      this.decoration});
  @override
  Widget build(BuildContext context) {
    final double queryData = MediaQuery.of(context).size.width;
    final double size = queryData > 600 ? iconSize! + 20.0 : iconSize!;
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: Stack(children: [
        Positioned(
          right: 2,
          top: 2,
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.red[200],
                borderRadius: BorderRadius.all(Radius.circular(18)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              width: 14,
              height: 14,
              child: Center(
                child: Text(
                  counter.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )),
        ),
        IconButton(
          iconSize: size,
          icon: Icon(
            Icons.shopping_cart,
            color: iconColor,
          ),
          onPressed: onPress,
        ),
      ]),
    );
  }
}

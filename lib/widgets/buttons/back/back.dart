import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';

typedef Press = void Function();

class ButtonBack extends StatelessWidget {
  final Press onPress;
  final double? iconSize;
  final Color? iconColor;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  ButtonBack(
      {required this.onPress,
      this.iconSize = 24.0,
      this.iconColor = AppColors.black,
      this.width,
      this.height,
      this.margin,
      this.decoration});
  @override
  Widget build(BuildContext context) {
    final double queryData = MediaQuery.of(context).size.width;
    final double size = queryData > 600 ? iconSize! + 20.0 : iconSize!;
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: decoration,
      child: IconButton(
        iconSize: size,
        icon: Icon(
          Icons.chevron_left,
          color: iconColor,
        ),
        onPressed: onPress,
      ),
    );
  }
}

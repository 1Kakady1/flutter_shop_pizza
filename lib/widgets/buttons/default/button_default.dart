import 'package:flutter/material.dart';

typedef Press = void Function();

class ButtonDefault extends StatelessWidget {
  final Press onPress;
  final Widget child;
  final BorderRadius? borderRadiusInlWell;
  final Color? colorInkWell;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final bool? isActive;
  final Color? colorActive;
  ButtonDefault({
    required this.onPress,
    required this.child,
    this.borderRadiusInlWell,
    this.colorInkWell,
    this.width,
    this.height,
    this.decoration,
    this.isActive,
    this.colorActive,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: width,
      height: height,
      decoration: decoration != null
          ? decoration!.copyWith(
              color: isActive == true ? colorActive : decoration?.color)
          : null,
      child: Stack(
        children: [
          child,
          new Positioned.fill(
              child: new Material(
                  color: colorInkWell ?? Colors.transparent,
                  child: new InkWell(
                    borderRadius: borderRadiusInlWell,
                    onTap: () => onPress(),
                  ))),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef Press = void Function();

class ButtonMenu extends StatelessWidget {
  final Press onOpen;
  ButtonMenu({required this.onOpen});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset("assets/svg/menu.svg", semanticsLabel: 'menu'),
      onPressed: onOpen,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef Press = void Function();

class ButtonMenu extends StatelessWidget {
  final Press onOpen;
  final double? iconSize;
  ButtonMenu({required this.onOpen, this.iconSize = 24.0});
  @override
  Widget build(BuildContext context) {
    final double queryData = MediaQuery.of(context).size.width;
    final double size = queryData > 600 ? iconSize! + 20.0 : iconSize!;
    return IconButton(
      iconSize: size,
      icon: SvgPicture.asset(
        "assets/svg/menu.svg",
        semanticsLabel: 'menu',
        width: size,
        height: size,
      ),
      onPressed: onOpen,
    );
  }
}

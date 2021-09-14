import 'package:flutter/material.dart';

class Bookmark extends StatelessWidget {
  final String text;
  final double top;
  final double? width;
  final double? heigt;
  final double? fontSize;
  const Bookmark(
      {Key? key,
      required this.text,
      required this.top,
      this.heigt = 80,
      this.width = 60,
      this.fontSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Image.asset(
          "assets/img/bookmark.png",
          width: width,
          height: heigt,
        ),
      ),
      Positioned.fill(
          top: top,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ))
    ]);
  }
}

import 'package:flutter/material.dart';

class Bookmark extends StatelessWidget {
  final String text;
  final double top;
  const Bookmark({Key? key, required this.text, required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Image.asset(
          "assets/img/bookmark.png",
          width: 60,
          height: 80,
        ),
      ),
      Positioned.fill(
          top: top,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ))
    ]);
  }
}

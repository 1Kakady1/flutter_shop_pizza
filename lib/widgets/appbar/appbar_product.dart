import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_time/styles/colors.dart';

class AppbarProduct extends StatelessWidget {
  const AppbarProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                FontAwesomeIcons.bars,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

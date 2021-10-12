import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';

typedef Press = void Function();

class ConuterFlat extends StatelessWidget {
  final int counter;
  final Press onAdd;
  final Press onSub;
  const ConuterFlat(
      {Key? key,
      required this.counter,
      required this.onAdd,
      required this.onSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double sizeButton = 39;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonDefault(
            borderRadiusInlWell: BorderRadius.all(Radius.circular(20)),
            width: sizeButton,
            height: sizeButton,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.minus,
                color: AppColors.red[300],
                size: 16,
              ),
            ),
            onPress: () {
              onSub();
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              counter.toString(),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          ButtonDefault(
            borderRadiusInlWell: BorderRadius.all(Radius.circular(20)),
            width: sizeButton,
            height: sizeButton,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: AppColors.red[300],
                size: 16,
              ),
            ),
            onPress: () {
              onAdd();
            },
          ),
        ],
      ),
    );
  }
}

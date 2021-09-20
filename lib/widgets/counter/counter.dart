import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';

typedef Press = void Function();

class Conuter extends StatelessWidget {
  final int counter;
  final Press onAdd;
  final Press onSub;
  const Conuter(
      {Key? key,
      required this.counter,
      required this.onAdd,
      required this.onSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonDefault(
            borderRadiusInlWell: BorderRadius.all(Radius.circular(20)),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.red[200],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.minus,
                color: AppColors.write,
                size: 16,
              ),
            ),
            onPress: () {
              onSub();
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              counter.toString(),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          ButtonDefault(
            borderRadiusInlWell: BorderRadius.all(Radius.circular(20)),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.red[200],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: AppColors.write,
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

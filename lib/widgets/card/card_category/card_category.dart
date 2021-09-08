import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_time/styles/colors.dart';

class CardCategory extends StatelessWidget {
  final double? height;
  final double? width;
  final String preview;
  final String name;
  final Function onPress;
  final EdgeInsets? margin;
  final bool isActive;
  CardCategory(
      {Key? key,
      this.height = 176,
      this.width = 95,
      this.margin,
      required this.isActive,
      required this.onPress,
      required this.name,
      required this.preview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String catName = FlutterI18n.translate(context, "cat_$name");
    return AnimatedContainer(
      height: this.height,
      width: this.width,
      margin: this.margin,
      decoration: BoxDecoration(
        color: isActive == true
            ? AppColors.red[200]
            : Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          SizedBox(height: 19),
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                preview,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )),
          SizedBox(height: 25),
          AnimatedDefaultTextStyle(
            style: isActive
                ? Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white)
                : Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: AppColors.black),
            duration: const Duration(milliseconds: 500),
            child: Text('${catName[0].toUpperCase()}${catName.substring(1)}'),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              width: 30,
              height: 30,
              color: isActive == true ? Colors.white : AppColors.black,
              child: Stack(children: [
                Positioned(
                  width: 30,
                  height: 30,
                  top: -6,
                  left: 1,
                  child: IconButton(
                    onPressed: () {
                      this.onPress();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.angleRight,
                      color:
                          isActive == true ? AppColors.red[200] : Colors.white,
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}

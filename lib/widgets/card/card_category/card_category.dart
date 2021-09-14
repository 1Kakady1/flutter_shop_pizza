import 'dart:developer';

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
  final double? mediaWidth;

  CardCategory(
      {Key? key,
      this.height = 176,
      this.width = 300,
      this.margin,
      this.mediaWidth,
      required this.isActive,
      required this.onPress,
      required this.name,
      required this.preview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String catName = FlutterI18n.translate(context, "cat_$name");
    final bool isMediaSM =
        (mediaWidth != null) && (mediaWidth! > 600) ? true : false;
    return AnimatedContainer(
      height: height,
      width: width,
      margin: margin,
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
                width: isMediaSM == true ? 110 : 50,
                height: isMediaSM == true ? 110 : 50,
                fit: BoxFit.cover,
              )),
          SizedBox(height: 25),
          AnimatedDefaultTextStyle(
            style: isActive
                ? Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white, fontSize: isMediaSM == true ? 22 : 16)
                : Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColors.black,
                    fontSize: isMediaSM == true ? 22 : 16),
            duration: const Duration(milliseconds: 500),
            child: Text('${catName[0].toUpperCase()}${catName.substring(1)}'),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              width: isMediaSM == true ? 58 : 30,
              height: isMediaSM == true ? 58 : 30,
              color: isActive == true ? Colors.white : AppColors.black,
              child: Stack(children: [
                Positioned(
                  width: isMediaSM == true ? 58 : 30,
                  height: isMediaSM == true ? 58 : 30,
                  top: isMediaSM == true ? 0 : -6,
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

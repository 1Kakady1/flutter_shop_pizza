import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/cart/button_cart.container.dart';
import 'package:pizza_time/widgets/buttons/menu/button_menu.dart';
import 'package:pizza_time/widgets/drawer/drawer.dart';

typedef PressClick = void Function();
typedef PressBack = void Function();

class AppbarProduct extends StatelessWidget {
  final PressClick? onToggle;
  final PressBack? onBack;
  final Color? iconColor;
  const AppbarProduct(
      {Key? key, this.onToggle, this.onBack, this.iconColor = AppColors.write})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(child: _getButton(onToggle, onBack, iconColor)),
          Container(child: Text("Menu")),
          Container(
              child: ButtonCartContainer(
            iconColor: AppColors.write,
          )),
        ],
      ),
    );
  }
}

Widget? _getButton(PressClick? onClick, PressBack? onBack, Color? iconColor) {
  if (onClick != null) {
    return Builder(
      builder: (BuildContext context) {
        return ButtonMenu(
          onOpen: () {
            onClick();
            AppDrawer.of(context)!.toggle();
          },
          iconColor: iconColor,
        );
      },
    );
  }

  if (onBack != null) {
    return Builder(
      builder: (BuildContext context) {
        return ButtonMenu(onOpen: () {
          onBack();
          Navigator.of(context).pop();
        });
      },
    );
  }

  return null;
}

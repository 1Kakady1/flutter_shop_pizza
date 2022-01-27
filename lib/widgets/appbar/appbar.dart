import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/buttons/back/back.dart';
import 'package:pizza_time/widgets/buttons/menu/button_menu.dart';
import 'package:pizza_time/widgets/drawer/drawer.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.container.dart';

typedef PressClick = void Function();
typedef PressBack = void Function();

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final PressClick? onClick;
  final PressBack? onBack;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;
  late GlobalKey<ScaffoldState> scaffold;
  final double? elevation;
  final EdgeInsets? paddingActions;
  final bool? isHideUserAvatar;
  final Color? color;
  final double? toolbarHeight;
  CustomAppBar(
      {Key? key,
      this.onBack,
      this.onClick,
      this.actions,
      this.leading,
      this.elevation,
      this.title,
      this.toolbarHeight,
      this.paddingActions,
      this.isHideUserAvatar,
      required this.scaffold,
      this.color = AppColors.write})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.toolbarHeight,
      backgroundColor: widget.color,
      title: widget.title,
      actions: [
        ...?widget.actions,
        widget.isHideUserAvatar == true
            ? SizedBox()
            : Container(
                padding: widget.paddingActions ?? EdgeInsets.all(0),
                child: UserAvatarContainer(
                  isTap: true,
                ))
      ],
      leading: Container(
        child: Row(
          children: [
            _getButton(widget.onClick, widget.onBack, widget.scaffold) ??
                SizedBox(),
          ],
        ),
      ),
      elevation: widget.elevation,
      centerTitle: true,
    );
  }
}

Widget? _getButton(
    PressClick? onClick, PressBack? onBack, GlobalKey<ScaffoldState> scaffold) {
  if (onClick != null) {
    return Builder(
      builder: (BuildContext context) {
        return ButtonMenu(onOpen: () {
          onClick();
          AppDrawer.of(context)!.toggle();
          //scaffold.currentState!.openDrawer();
        });
      },
    );
  }

  if (onBack != null) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(left: 10),
          child: ButtonBack(
            onPress: () {
              onBack();
              Navigator.of(context).pop();
            },
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.write,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  spreadRadius: 3,
                  blurRadius: 12,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            iconColor: AppColors.black,
          ),
        );
      },
    );
  }

  return null;
}

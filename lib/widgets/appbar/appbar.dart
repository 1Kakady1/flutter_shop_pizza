import 'package:flutter/material.dart';
import 'package:pizza_time/widgets/buttons/menu/button_menu.dart';
import 'package:pizza_time/widgets/drawer/drawer.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.container.dart';
import 'package:pizza_time/widgets/user/title/user_title.dart';

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

  CustomAppBar(
      {Key? key,
      this.onBack,
      this.onClick,
      this.actions,
      this.leading,
      this.elevation,
      this.title,
      required this.scaffold})
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
      title: widget.title ?? UserTitle(),
      actions: [...?widget.actions, UserAvatarContainer()],
      leading: _getButton(widget.onClick, widget.onBack, widget.scaffold),
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
        return ButtonMenu(onOpen: () {
          onBack();
          Navigator.of(context).pop();
        });
      },
    );
  }

  return null;
}

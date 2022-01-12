import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/styles/colors.dart';

class UserAvatar extends StatelessWidget {
  final bool isAuth;
  final UserCustom user;
  final bool? isBorder;
  final double? size;
  final bool? hideName;
  UserAvatar(
      {required this.isAuth,
      required this.user,
      this.isBorder,
      this.size = 40.0,
      this.hideName = false});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: size != null && isBorder == true ? size! + 3.0 : size,
      child: CircleAvatar(
        radius: size,
        backgroundColor: AppColors.red[300],
        child: Text(
          hideName == true ? "" : _getAvatarName(isAuth, user),
          style: TextStyle(color: Colors.white),
        ),
        backgroundImage: _getAvatar(isAuth, user, context),
      ),
    );
  }
}

String _getAvatarName(bool isAuth, UserCustom info) {
  if (isAuth == false) {
    return "";
  }
  final nameSplit = info.name.toUpperCase().split("");
  return nameSplit[0] + nameSplit[1];
}

ImageProvider<Object>? _getAvatar(
    bool isAuth, UserCustom info, BuildContext context) {
  final isImageUser = info.preview != null && info.preview != "" ? true : false;
  final ImageProvider fake = AssetImage('assets/img/man.png');
  final ImageProvider? preview = isAuth == true
      ? isImageUser == true
          ? NetworkImage(info.preview!)
          : fake
      : fake;

  return preview;
}

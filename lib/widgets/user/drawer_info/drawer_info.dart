import 'package:flutter/material.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.container.dart';

class DraverUserInfo extends StatelessWidget {
  final bool isAuth;
  final User user;
  final bool? isBorder;
  final double? size;
  const DraverUserInfo(
      {Key? key,
      required this.isAuth,
      required this.user,
      this.isBorder,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          UserAvatarContainer(
            isBorder: isBorder,
            size: size,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.container.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.dart';

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
    final String title = isAuth == true
        ? user.email
        : FlutterI18n.translate(context, "user.acc_not_title");
    final String subTitle = isAuth == true
        ? user.name
        : FlutterI18n.translate(context, "user.acc_not_sub");
    var onPrres = isAuth == true ? () => 0 : () => null;
    final double queryDataWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPrres,
      child: Container(
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: UserAvatar(
                user: user,
                isAuth: isAuth,
                isBorder: isBorder,
                size: size,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: queryDataWidth > 600 ? 18 : 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: queryDataWidth > 600 ? 18 : 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

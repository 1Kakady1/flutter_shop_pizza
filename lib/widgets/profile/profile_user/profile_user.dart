import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/widgets/upload_img_in_firebase/upload_img_in_firebase.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.dart';

class ProfileUser extends StatelessWidget {
  final bool isAuth;
  final UserCustom user;
  final void Function(UserCustom user) onChangeUserInfo;
  final _api = new Api();
  ProfileUser(
      {required this.isAuth,
      required this.user,
      required this.onChangeUserInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          UserAvatar(
            user: user,
            isAuth: true,
            size: 80,
            isBorder: true,
            hideName: true,
          ),
          UploadImgInFirebase(onUplodinSuccess: (String url) async {
            _api.updateUserField(user.id, "preview", url).then((value) {
              onChangeUserInfo(user.copyWith(preview: url));
            });
          }),
        ],
      ),
    );
  }
}

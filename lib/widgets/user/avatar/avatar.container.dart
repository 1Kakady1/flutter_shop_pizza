import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/redux/state/user/user.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.dart';
import 'package:redux/redux.dart';

class UserAvatarContainer extends StatelessWidget {
  final bool? isBorder;
  final double? size;
  const UserAvatarContainer({Key? key, this.isBorder, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewUserAvatar>(
            converter: (store) => _ViewUserAvatar.fromStore(store),
            builder: (context, vm) {
              return UserAvatar(
                isAuth: vm.isAuth,
                user: vm.user,
                isBorder: isBorder,
                size: size,
              );
            }));
  }
}

class _ViewUserAvatar {
  final bool isAuth;
  final User user;

  _ViewUserAvatar({required this.isAuth, required this.user});

  static _ViewUserAvatar fromStore(Store<AppState> store) {
    return _ViewUserAvatar(
        isAuth: UserSelectors.isAuth(store.state),
        user: UserSelectors.user(store.state));
  }
}

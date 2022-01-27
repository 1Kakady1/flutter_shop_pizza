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
  final bool? isTap;
  const UserAvatarContainer({Key? key, this.isBorder, this.size, this.isTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double queryData = MediaQuery.of(context).size.width;
    final double sizeAvatar = queryData > 600 ? 40 : 20;
    return Container(
        child: StoreConnector<AppState, _ViewUserAvatar>(
            distinct: true,
            converter: (store) => _ViewUserAvatar.fromStore(store),
            builder: (context, vm) {
              return UserAvatar(
                size: size != null ? size : sizeAvatar,
                isAuth: vm.isAuth,
                user: vm.user,
                isBorder: isBorder,
                isTap: isTap,
              );
            }));
  }
}

class _ViewUserAvatar {
  final bool isAuth;
  final UserCustom user;
  _ViewUserAvatar({required this.isAuth, required this.user});

  @override
  bool operator ==(other) {
    return (other is _ViewUserAvatar) &&
        (this.user == other.user) &&
        (this.isAuth == other.isAuth);
  }

  @override
  int get hashCode {
    return isAuth.hashCode + user.hashCode;
  }

  static _ViewUserAvatar fromStore(Store<AppState> store) {
    return _ViewUserAvatar(
        isAuth: UserSelectors.isAuth(store.state),
        user: UserSelectors.user(store.state));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/redux/state/user/user.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/user/drawer_info/drawer_info.dart';
import 'package:redux/redux.dart';

class DraverUserInfoContainer extends StatelessWidget {
  final bool? isBorder;
  final double? size;
  const DraverUserInfoContainer({Key? key, this.isBorder, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewDraverUserInfo>(
            distinct: true,
            converter: (store) => _ViewDraverUserInfo.fromStore(store),
            builder: (context, vm) {
              return DraverUserInfo(
                isAuth: vm.isAuth,
                user: vm.user,
                isBorder: isBorder,
                size: size,
              );
            }));
  }
}

class _ViewDraverUserInfo {
  final bool isAuth;
  final User user;

  _ViewDraverUserInfo({required this.isAuth, required this.user});
  @override
  bool operator ==(other) {
    return (other is _ViewDraverUserInfo) &&
        (this.user == other.user) &&
        (this.isAuth == other.isAuth);
  }

  @override
  int get hashCode {
    return isAuth.hashCode + user.hashCode;
  }

  static _ViewDraverUserInfo fromStore(Store<AppState> store) {
    return _ViewDraverUserInfo(
        isAuth: UserSelectors.isAuth(store.state),
        user: UserSelectors.user(store.state));
  }
}

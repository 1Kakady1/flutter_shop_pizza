import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/order.model.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/redux/state/history/history.actions.dart';
import 'package:pizza_time/redux/state/history/history.selector.dart';
import 'package:pizza_time/redux/state/user/user.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/profile/profile_history/profile_history.dart';
import 'package:redux/redux.dart';

class ProfileHistoryContainer extends StatefulWidget {
  const ProfileHistoryContainer({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileHistoryContainerState createState() =>
      _ProfileHistoryContainerState();
}

class _ProfileHistoryContainerState extends State<ProfileHistoryContainer> {
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewProfileHistory>(
            onInit: (store) {
              if (store.state.history.history.length == 0) {
                _timer = new Timer(
                    Duration(seconds: 1),
                    () => {
                          store.dispatch(RequestHistoryAction(
                              error: "",
                              isLoad: true,
                              offset: null,
                              id: store.state.user.info.id))
                        });
              }
            },
            distinct: true,
            converter: (store) => _ViewProfileHistory.fromStore(store),
            builder: (context, vm) {
              return ProfileHistory(
                  isAuth: vm.isAuth,
                  user: vm.user,
                  error: vm.error,
                  history: vm.history,
                  isLoad: vm.isLoadHistory,
                  offset: vm.offset);
            }));
  }
}

class _ViewProfileHistory {
  final bool isAuth;
  final UserCustom user;
  final List<OrderModel> history;
  final bool isLoadHistory;
  final String error;
  final offset;
  _ViewProfileHistory(
      {required this.isAuth,
      required this.user,
      required this.history,
      required this.isLoadHistory,
      required this.error,
      this.offset});
  @override
  bool operator ==(other) {
    return (other is _ViewProfileHistory) &&
        (this.user == other.user) &&
        (this.isAuth == other.isAuth) &&
        (this.history == other.history) &&
        (this.isLoadHistory == other.isLoadHistory);
  }

  @override
  int get hashCode {
    return isAuth.hashCode +
        user.hashCode +
        history.hashCode +
        isLoadHistory.hashCode;
  }

  static _ViewProfileHistory fromStore(Store<AppState> store) {
    return _ViewProfileHistory(
        isAuth: UserSelectors.isAuth(store.state),
        user: UserSelectors.user(store.state),
        history: HistorySelectors.history(store.state),
        error: HistorySelectors.error(store.state),
        offset: HistorySelectors.offset(store.state),
        isLoadHistory: HistorySelectors.isLoad(store.state));
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/model/order.model.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/card/card_history_item/card_history_item.dart';

class ProfileHistory extends StatefulWidget {
  final bool isAuth;
  final UserCustom user;
  final bool isLoad;
  final offset;
  final List<OrderModel> history;
  final String error;
  //final void Function(UserCustom user) onChangeUserInfo;

  ProfileHistory(
      {required this.isAuth,
      required this.user,
      required this.error,
      required this.history,
      required this.isLoad,
      required this.offset});

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("${widget.error}");
    return _HistoryContent.contnent(
      error: widget.error,
      isLoad: widget.isLoad,
      history: widget.history,
    );
  }
}

abstract class _HistoryContent extends StatelessWidget {
  final bool isLoad;
  final List<OrderModel> history;
  final String error;
  const _HistoryContent(
      {Key? key,
      required this.isLoad,
      required this.history,
      required this.error})
      : super(key: key);
  @override
  factory _HistoryContent.contnent(
      {Key? key,
      required bool isLoad,
      required List<OrderModel> history,
      required String error}) {
    int value = 0;

    if (history.length == 0 && isLoad == false && error == "") {
      value = 1;
    }

    if (history.length > 0 && error == "") {
      value = 2;
    }

    if (error != "" && isLoad == false) {
      value = 3;
    }

    switch (value) {
      case 0:
        return _LoadingHistory(error: error, isLoad: isLoad, history: history);
      case 1:
        return _EmptyHistory(error: error, isLoad: isLoad, history: history);
      case 2:
        return _ContentHistory(error: error, isLoad: isLoad, history: history);
      case 3:
        return _ErrorHistory(error: error, isLoad: isLoad, history: history);
      default:
        return _EmptyHistory(error: error, isLoad: isLoad, history: history);
    }
  }
}

class _LoadingHistory extends _HistoryContent {
  final bool isLoad;
  final List<OrderModel> history;
  final String error;
  _LoadingHistory(
      {Key? key,
      required this.isLoad,
      required this.history,
      required this.error})
      : super(key: key, isLoad: isLoad, history: history, error: error);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: _containerFull([], context, isLoad, error));
  }
}

class _ContentHistory extends _HistoryContent {
  final bool isLoad;
  final List<OrderModel> history;
  final String error;
  _ContentHistory(
      {Key? key,
      required this.isLoad,
      required this.history,
      required this.error})
      : super(key: key, isLoad: isLoad, history: history, error: error);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Card(
          color: AppColors.write,
          margin: const EdgeInsets.all(15),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(FlutterI18n.translate(context, "title.order")),
                      Text(history[index].date)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: history[index].products.map((e) {
                    return Column(
                      children: [
                        CardHistoryItem(product: e),
                        Divider(),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        );
      },
      childCount: history.length,
    ));
  }
}

class _ErrorHistory extends _HistoryContent {
  final bool isLoad;
  final List<OrderModel> history;
  final String error;
  _ErrorHistory(
      {Key? key,
      required this.isLoad,
      required this.history,
      required this.error})
      : super(key: key, isLoad: isLoad, history: history, error: error);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: _containerFull([
      Center(
          child: Image.asset(
        "assets/img/error.png",
        width: 325,
        height: 161,
      )),
      Center(
        child: Text("Error: $error"),
      ),
    ], context, isLoad, error));
  }
}

class _EmptyHistory extends _HistoryContent {
  final bool isLoad;
  final List<OrderModel> history;
  final String error;
  _EmptyHistory(
      {Key? key,
      required this.isLoad,
      required this.history,
      required this.error})
      : super(key: key, isLoad: isLoad, history: history, error: error);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _containerFull([
        Center(
            child: Image.asset(
          "assets/img/error-404.png",
          width: 325,
          height: 161,
        )),
        Center(
          child: Text(FlutterI18n.translate(context, "not_found")),
        ),
      ], context, isLoad, error),
    );
  }
}

Widget _loaderAndInfo(
    Widget widget, BuildContext ctx, bool loading, String? msg) {
  return Container(
    child: Stack(
      children: [
        widget,
        loading == true
            ? Positioned(
                left: MediaQuery.of(ctx).size.width / 2 - 14,
                top: 60.0,
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.red[200],
                      strokeWidth: 7.0,
                    ),
                  ),
                ))
            : SizedBox(),
      ],
    ),
  );
}

Widget _containerFull(
    List<Widget> wd, BuildContext ctx, bool loading, String? msg) {
  return _loaderAndInfo(
      Container(
        height: MediaQuery.of(ctx).size.height - 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: wd,
        ),
      ),
      ctx,
      loading,
      msg);
}

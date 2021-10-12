import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/redux/state/cart/cart.action.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/card/card_cart_item/card_cart_item.dart';
import 'package:redux/redux.dart';

class AnimatedListCustom extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<CartItem> items;
  final int? delay;

  AnimatedListCustom({Key? key, required this.items, this.delay})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) =>
          buildItem(items[index], index, animation, context),
    );
  }

  Widget buildItem(CartItem item, int index, Animation<double> animation,
          BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: CardCartItem(
          product: item,
          animation: animation,
          onSub: () =>
              {_onSub(item, item.productSize, item.count, index, context)},
          onAdd: () =>
              {_onAdd(item, item.productSize, item.count, index, context)},
          onRemove: () => {_onRemove(item, item.productSize, index, context)},
        ),
      );

  void _onAdd(CartItem? product, String size, int count, int index,
      BuildContext context) {
    final Store<AppState> store =
        StoreProvider.of<AppState>(context, listen: false);
    if (product != null)
      store.dispatch(CartAddAction(cartItem: product, size: size));
  }

  void _onRemove(
      CartItem? product, String size, int index, BuildContext context) {
    final Store<AppState> store =
        StoreProvider.of<AppState>(context, listen: false);
    if (product != null) {
      this.removeItem(index);
      Timer(Duration(seconds: this.delay ?? 1),
          () => store.dispatch(CartRemoveAction(product: product, size: size)));
    }
  }

  void _onSub(CartItem? product, String size, int count, int index,
      BuildContext context) {
    final Store<AppState> store =
        StoreProvider.of<AppState>(context, listen: false);
    bool isRemove = false;
    if (count - 1 == 0) {
      isRemove = true;
      this.removeItem(index);
      Timer(Duration(seconds: this.delay ?? 1),
          () => store.dispatch(CartSubAction(cartItem: product, size: size)));
    }
    if (product != null && count - 1 >= 0 && isRemove == false)
      store.dispatch(CartSubAction(cartItem: product, size: size));
  }

  void insertItem(int index, CartItem item) {
    items.insert(index, item);
    listKey.currentState?.insertItem(index);
  }

  void removeItem(int index) {
    final item = items.removeAt(index);

    listKey.currentState?.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation, context),
    );
  }
}

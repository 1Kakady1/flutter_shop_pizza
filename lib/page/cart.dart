import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/redux/state/cart/cart.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/appbar/appbar.dart';
import 'package:pizza_time/widgets/buttons/cart/button_cart.container.dart';
import 'package:pizza_time/widgets/product_panel/product_panel.dart';
import 'package:redux/redux.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffold: _scaffoldKey,
        isHideUserAvatar: true,
        color: Colors.transparent,
        elevation: 0,
        onBack: () => 0,
        actions: [
          Container(
            width: 44,
            height: 44,
            margin: EdgeInsets.only(right: 10),
            child: Center(
              child: ButtonCartContainer(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.write,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                iconColor: AppColors.black,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration.zero);
          },
          child: Container(
              child: StoreConnector<AppState, _ViewCartPage>(
                  distinct: true,
                  converter: (store) => _ViewCartPage.fromStore(store),
                  builder: (context, vm) {
                    return Text("Cart");
                  }))),
      bottomNavigationBar: ProductPanel(),
    );
  }
}

class _ViewCartPage {
  final List<CartItem> cartList;
  _ViewCartPage({
    required this.cartList,
  });

  bool operator ==(other) {
    return (other is _ViewCartPage) && (this.cartList == other.cartList);
  }

  @override
  int get hashCode {
    return cartList.hashCode;
  }

  static _ViewCartPage fromStore(Store<AppState> store) {
    return _ViewCartPage(
      cartList: CartSelectors.products(store.state),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/redux/state/cart/cart.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/animated_list/animated_list.dart';
import 'package:pizza_time/widgets/appbar/appbar.dart';
import 'package:pizza_time/widgets/buttons/cart/button_cart.container.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';
import 'package:pizza_time/widgets/cart_panel/cart_patel.dart';
import 'package:redux/redux.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final double heightPanel = 220;
    return Scaffold(
        backgroundColor: Colors.white,
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
                  isPressOff: true,
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
                      return vm.cartList.length == 0
                          ? Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Image.asset(
                                    "assets/img/empty-cart.png",
                                    width: 220,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(FlutterI18n.translate(
                                        context, "title.cart_empty")),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Center(
                                    child: ButtonDefault(
                                      decoration: BoxDecoration(
                                          color: AppColors.red[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      borderRadiusInlWell:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            FlutterI18n.translate(
                                                context, "button.go_product"),
                                            style: TextStyle(
                                                color: AppColors.write)),
                                      ),
                                      onPress: () => {
                                        Navigator.popAndPushNamed(
                                            context, "/products")
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          : AnimatedListCustom(
                              items: vm.cartList,
                              delay: 1,
                            );
                    }))),
        bottomNavigationBar: StoreConnector<AppState, _ViewCartPage>(
            distinct: true,
            converter: (store) => _ViewCartPage.fromStore(store),
            builder: (context, vm) {
              return AnimatedOpacity(
                  opacity: vm.cartList.length == 0 ? 0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: CartPanel(
                    height: vm.cartList.length > 0 ? heightPanel : 0,
                  ));
            }));
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

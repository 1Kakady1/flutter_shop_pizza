import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/model/product_filter.model.dart';
import 'package:pizza_time/redux/state/cart/cart.action.dart';
import 'package:pizza_time/redux/state/cart/cart.selector.dart';
import 'package:pizza_time/redux/state/product/product.actions.dart';
import 'package:pizza_time/redux/state/product/product.selector.dart';
import 'package:pizza_time/redux/state/products/products.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/appbar/appbar.dart';
import 'package:pizza_time/widgets/bookmark/bookmark.dart';
import 'package:pizza_time/widgets/buttons/cart/button_cart.container.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';
import 'package:pizza_time/widgets/counter/counter.dart';
import 'package:pizza_time/widgets/gallery/gallery.dart';
import 'package:pizza_time/widgets/gallery/gallery.model.dart';
import 'package:pizza_time/widgets/product_panel/product_panel.dart';
import 'package:redux/redux.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration.zero);
          },
          child: Container(
              child: StoreConnector<AppState, _ViewProductPage>(
                  distinct: true,
                  onInit: (store) {
                    store.dispatch(RequestProductAction(
                        id: arguments["id"], error: "", isLoad: true));
                  },
                  converter: (store) =>
                      _ViewProductPage.fromStore(store, arguments["id"]),
                  builder: (context, vm) {
                    final item = _getProduct(vm.product, arguments["id"],
                        arguments["product"] as Product?);
                    final index = vm.cartPrductIndex;
                    final int count = index == -1 ? 0 : vm.cart[index].count;
                    final List<GalleryItem> gallery =
                        _buildGalleryItems(vm.product?.gallary);

                    return _content(
                        isLoad: vm.isLoad,
                        product: item,
                        error: vm.error,
                        context: context,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              CustomAppBar(
                                scaffold: _scaffoldKey,
                                isHideUserAvatar: true,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.shadow,
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        iconColor: AppColors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 45),
                                    child: Container(
                                      width: double.infinity,
                                      height: 526.0,
                                      decoration: BoxDecoration(
                                        color: AppColors.write,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.shadow,
                                            spreadRadius: 3,
                                            blurRadius: 16,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(526),
                                            bottomRight: Radius.circular(526)),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 37,
                                          ),
                                          Text(
                                            vm.product?.title ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 36),
                                            child: Text(
                                              vm.product?.desc ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                              softWrap: false,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 43,
                                          ),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.network(
                                                vm.product?.preview ?? "",
                                                width: 220,
                                                height: 220,
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return Image.asset(
                                                    "assets/img/no-img.png",
                                                    width: 220,
                                                    height: 220,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )),
                                          SizedBox(
                                            height: 26,
                                          ),
                                          _sizeButton(
                                              vm.product?.filter,
                                              store,
                                              vm.size,
                                              vm.product?.isUnit,
                                              vm.product?.unit)
                                        ],
                                      ),
                                    ),
                                  ),
                                  vm.product?.isTop == true
                                      ? Positioned(
                                          right: 6,
                                          top: -10,
                                          child: Bookmark(
                                            text: "TOP",
                                            top: 24,
                                          ))
                                      : SizedBox(),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 50.0),
                                child: Conuter(
                                  counter: count,
                                  onAdd: () =>
                                      _onAdd(vm.product, vm.size, count),
                                  onSub: () =>
                                      _onSub(vm.product, vm.size, count),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              vm.product?.gallary != null
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          FlutterI18n.translate(
                                              context, "title.gallery"),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                            child: Gallery(
                                          gallery: gallery,
                                        )),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ));
                  }))),
      bottomNavigationBar: ProductPanel(),
    );
  }

  List<GalleryItem> _buildGalleryItems(List<String?>? gallery) {
    List<GalleryItem> list = [];
    if (gallery != null) {
      for (int i = 0; i < gallery.length; i++) {
        list.add(
            GalleryItem(id: "tag-" + i.toString(), resource: gallery[i] ?? ""));
      }
    }

    return list;
  }

  void _onAdd(Product? product, String size, int count) {
    final Store<AppState> store =
        StoreProvider.of<AppState>(context, listen: false);
    if (product != null)
      store.dispatch(CartAddAction(product: product, size: size));
  }

  void _onSub(Product? product, String size, int count) {
    final Store<AppState> store =
        StoreProvider.of<AppState>(context, listen: false);
    if (product != null && count - 1 >= 0)
      store.dispatch(CartSubAction(product: product, size: size));
  }
}

Widget _sizeButton(ProductFilter? filter, Store<AppState> store,
    String sizeActive, bool? isUnit, String? unit) {
  final List<Widget> list = [];
  final lenSize = filter?.size?.length ?? 0;
  if (filter != null && filter.size != null) {
    for (int i = 0; i < lenSize; i++) {
      final active = sizeActive == filter.size?[i] ? true : false;
      final String size = filter.size?[i] ?? "";
      final String title = isUnit == true && filter.size?[i] != null
          ? "${(int.parse(size) / 1000).toString()}$unit"
          : size.toUpperCase();
      list.add(Padding(
        padding: EdgeInsets.only(top: i == 1 && lenSize > 2 ? 32 : 0),
        child: ButtonDefault(
          colorActive: AppColors.red[200],
          isActive: active,
          decoration: BoxDecoration(
            color: AppColors.write,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Container(
            width: 50,
            height: 50,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: active ? AppColors.write : AppColors.black,
                    fontSize: isUnit == true ? 14 : 20),
              ),
            ),
          ),
          onPress: () =>
              store.dispatch(ChangeProductSize(filter.size?[i] ?? "")),
        ),
      ));
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Row(
      mainAxisAlignment: lenSize == 1
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: list,
    ),
  );
}

Widget _containerFull(List<Widget> wd, BuildContext ctx) {
  return Container(
    height: MediaQuery.of(ctx).size.height - 130,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: wd,
    ),
  );
}

Widget _content(
    {required Widget child,
    required Product? product,
    required bool isLoad,
    required String error,
    required BuildContext context}) {
  if (error != "") {
    return _containerFull([
      Center(
          child: Image.asset(
        "assets/img/error.png",
        width: 325,
        height: 161,
      )),
      Center(
        child: Text("Error: $error"),
      ),
    ], context);
  }

  if (product != null && isLoad == false) {
    return child;
  }

  if (isLoad == true) {
    return _containerFull([
      Center(
        child: new CircularProgressIndicator(
          color: AppColors.red[200],
        ),
      ),
    ], context);
  }

  return _containerFull([
    Center(
        child: Image.asset(
      "assets/img/error-404.png",
      width: 325,
      height: 161,
    )),
    Center(
      child: Text(FlutterI18n.translate(context, "not_found")),
    ),
  ], context);
  ;
}

Product? _getProduct(
  Product? product,
  String id,
  Product? arguments,
) {
  if (id == product?.id) {
    return product;
  }

  if (arguments != null) {
    return arguments;
  }
}

class _ViewProductPage {
  final Product? product;
  final bool isLoad;
  final String error;
  final String size;
  final List<CartItem> cart;
  final int cartPrductIndex;
  _ViewProductPage(
      {required this.product,
      required this.isLoad,
      required this.error,
      required this.size,
      required this.cart,
      required this.cartPrductIndex});

  bool operator ==(other) {
    return (other is _ViewProductPage) &&
        (this.product == other.product) &&
        (this.isLoad == other.isLoad) &&
        (this.size == other.size) &&
        (this.cart == other.cart);
  }

  @override
  int get hashCode {
    return product.hashCode + size.hashCode + isLoad.hashCode + cart.hashCode;
  }

  static _ViewProductPage fromStore(Store<AppState> store, String? id) {
    final int index = ProductsSelectors.productIndexByID(id ?? "")(store.state);
    final item = index == -1
        ? ProductSelectors.products(store.state)
        : ProductsSelectors.products(store.state)[index];
    final size = ProductSelectors.size(store.state);
    return _ViewProductPage(
        product: item,
        cart: CartSelectors.products(store.state),
        cartPrductIndex: CartSelectors.getCartProductIndex(
            item?.id ?? "", size)(store.state),
        isLoad: ProductSelectors.isLoad(store.state),
        size: size,
        error: ProductSelectors.error(store.state));
  }
}

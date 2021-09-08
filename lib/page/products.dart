import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/state/products/products.model.dart';
import 'package:pizza_time/redux/state/products/products.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/widgets/appbar/appbar.dart';
import 'package:redux/redux.dart';

//https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_database/firebase_database/example/lib/main.dart
class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final GlobalKey<ScaffoldState> _scaffoldProductsKey =
      new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    var prod = store.state.products.products;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldProductsKey,
      appBar: CustomAppBar(
        scaffold: _scaffoldProductsKey,
        elevation: 0,
        onBack: () => 0,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => store.dispatch(getProducts()),
                  child: Text("Get image")),
              StoreConnector<AppState, Products>(
                  converter: (store) =>
                      ProductsSelectors.toProducts(store.state),
                  builder: (context, vm) => _productsList(vm)),
            ],
          )),
    );
  }
}

Widget _productsList(Products products) {
  return Container(
    child: products.isLoad
        ? Text("loading")
        : Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              itemCount: products.products.length,
              itemExtent: 120,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    title: Text(products.products[index].title),
                  ),
                );
              },
            ),
          ),
  );
}

SnackBar _snackBar(String msg) {
  return SnackBar(
    content: Text(msg),
    duration: const Duration(milliseconds: 2000),
    width: 310.0, // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

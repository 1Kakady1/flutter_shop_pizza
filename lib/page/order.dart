import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

//https://www.youtube.com/watch?v=bpvpbQF-2Js&ab_channel=FunwithFlutter
//https://github.com/funwithflutter/lit_firebase_auth_ui_demo
class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final mediaWidth = constraints.maxWidth;
        return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text("Order"),
                ),
              ],
            ));
      }),
    );
  }
}

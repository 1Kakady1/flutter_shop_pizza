import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/appbar/appbar_product.dart';
import 'package:pizza_time/widgets/appbar/appbar_sliver_product/appbar_sliver_product.dart.container.dart';
import 'package:pizza_time/widgets/product_list/product_list.sliver.container.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: AppbarProduct(),
              backgroundColor: AppColors.red[300],
              pinned: true,
              floating: true,
              expandedHeight: (100.0 + statusBarHeight),
              flexibleSpace: FlexibleSpaceBar(
                background: AppbarSliverProductContainer(),
              ),
            ),
            ProductSliverContainer()
          ],
        ),
        onRefresh: () => Future.value(true),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/card/card_product/card_product.dart';
import 'package:pizza_time/widgets/card/card_product/card_product.skeleton.dart';
import 'package:pizza_time/widgets/popular/popular.container.dart';

class PopularList extends StatelessWidget {
  final bool isLoad;
  final List<Product> products;
  final String cat;
  final double? constraintsMaxWidth;
  final GotoProducts gotoProducts;
  const PopularList(
      {Key? key,
      required this.products,
      required this.isLoad,
      required this.cat,
      required this.gotoProducts,
      this.constraintsMaxWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String catName = FlutterI18n.translate(context, "cat_$cat");
    final bool isMediaSM =
        constraintsMaxWidth != null && constraintsMaxWidth! > 600
            ? true
            : false;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(FlutterI18n.translate(context, "popular"),
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: isMediaSM == true ? 26 : 18)),
              GestureDetector(
                onTap: () {
                  gotoProducts(cat, context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${FlutterI18n.translate(context, "view")} $catName >",
                      style: TextStyle(
                          color: AppColors.red[200],
                          fontSize: isMediaSM == true ? 22 : 12)),
                ),
              )
            ],
          ),
          SizedBox(height: 18),
          Wrap(
            children: [
              ..._listPopular(products, isLoad, context, constraintsMaxWidth)
            ],
          )
        ],
      ),
    );
  }
}

List<Widget> _listPopular(List<Product> product, bool isLoad,
    BuildContext context, double? constraintsMaxWidth) {
  if (isLoad == true) {
    return [CardProductSkeleton()];
  }
  final bool isMediaSM =
      constraintsMaxWidth != null && constraintsMaxWidth > 600 ? true : false;
  List<Widget> list = [];
  for (int i = 0; i < product.length; i++) {
    final double marginLeft = isMediaSM == true && i.isOdd ? 16 : 0;
    final double marginRight = isMediaSM == true && i.isEven ? 16 : 0;
    list.add(Container(
      width: isMediaSM ? (constraintsMaxWidth / 2) - 32 : double.infinity,
      margin: EdgeInsets.only(bottom: 16, left: marginLeft, right: marginRight),
      child: CardProduct(
        product: product[i],
        onTap: () => Navigator.pushNamed(context, "/product",
            arguments: {"id": product[i].id, "product": product[i]}),
      ),
    ));
  }
  return list;
}

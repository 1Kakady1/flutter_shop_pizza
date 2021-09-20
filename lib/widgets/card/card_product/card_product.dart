import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_time/helpers/product.utils.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/bookmark/bookmark.dart';

typedef OnTapType = void Function();

class CardProduct extends StatelessWidget {
  final Product product;
  final OnTapType onTap;
  CardProduct({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? size = product.filter?.size?[0];
    final double price = getPrice(
        price: product.price, filtersSize: product.filter?.size, size: size);
    final String unit =
        product.isUnit == true && size != null ? "($size ${product.unit})" : "";
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      product.preview,
                      width: 325,
                      height: 161,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          "assets/img/no-img.png",
                          width: 325,
                          height: 161,
                          fit: BoxFit.cover,
                        );
                      },
                    )),
                product.isTop == true
                    ? Positioned(
                        right: 6,
                        top: -10,
                        child: Bookmark(
                          text: "TOP",
                          top: 24,
                        ))
                    : SizedBox()
              ]),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      product.title,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "\$ $price $unit",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      product.desc,
                      style: Theme.of(context).textTheme.subtitle2,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FaIcon(
                    FontAwesomeIcons.angleRight,
                    color: AppColors.red[300],
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        new Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () => onTap(),
                )))
      ]),
    );
  }
}

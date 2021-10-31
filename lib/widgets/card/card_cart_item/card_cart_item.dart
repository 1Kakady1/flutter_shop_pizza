import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:pizza_time/helpers/media_query.dart';
import 'package:pizza_time/helpers/product.utils.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/card/card_cart_item/card_cart_item.media.dart';
import 'package:pizza_time/widgets/counter_flat/counter_flat.dart';

typedef Press = void Function();

class CardCartItem extends StatefulWidget {
  final CartItem product;
  final Press onAdd;
  final Press onSub;
  final Press onRemove;
  final ChangeCartItemCommentsType onChangeComments;
  final Animation<double> animation;
  CardCartItem(
      {Key? key,
      required this.product,
      required this.onAdd,
      required this.onSub,
      required this.onRemove,
      required this.onChangeComments,
      required this.animation})
      : super(key: key);

  @override
  _CardCartItemState createState() => _CardCartItemState();
}

class _CardCartItemState extends State<CardCartItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.product.comments ?? "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? size = widget.product.productSize;
    final double price = getPrice(
        price: widget.product.price,
        filtersSize: widget.product.filter?.size,
        size: size);
    final double mediaWidth =
        MediaQuery.of(context).size.width >= 600 ? 600 : 0;
    final styles = getMediaQueryStyles(MediaQuery.of(context).size.width,
        MediaSizeEnum.sm, CardCartItemMedia.mapMedia);
    final TextStyle titileStyle = TextStyle(
        fontSize: styles!["title_font_size"], fontWeight: FontWeight.bold);
    final String sizeTitle = widget.product.isUnit == true
        ? "${(int.parse(widget.product.productSize) / 1000).toString()}"
        : widget.product.productSize.toUpperCase();
    return ScaleTransition(
      scale: widget.animation,
      child: Container(
        height: styles["container_height"],
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(children: [
                      Image.network(
                        widget.product.preview,
                        width: styles["size_img"],
                        height: styles["size_img"],
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            "assets/img/no-img.png",
                            width: styles["size_img"],
                            height: styles["size_img"],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                          right: 2,
                          top: 2,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: AppColors.red[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                            child: Center(
                                child: Text(
                              sizeTitle,
                              style: TextStyle(color: AppColors.write),
                            )),
                          ))
                    ])),
                SizedBox(
                  width: mediaWidth >= 600 ? 30 : 0,
                ),
                Container(
                  height: styles["size_img"],
                  child: Padding(
                    padding: EdgeInsets.all(mediaWidth >= 600 ? 24.00 : 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: styles["title_width"],
                                height: 40,
                                child: mediaWidth < 600
                                    ? Marquee(
                                        accelerationCurve: Curves.easeInCirc,
                                        blankSpace: 60.0,
                                        pauseAfterRound: Duration(seconds: 6),
                                        text: widget.product.title,
                                        style: titileStyle,
                                      )
                                    : Text(
                                        widget.product.title,
                                        style: titileStyle,
                                      )),
                            ConuterFlat(
                              counter: widget.product.count,
                              onAdd: widget.onAdd,
                              onSub: widget.onSub,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: styles["price"]["contianer"]["width"],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  this.widget.onRemove();
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.times,
                                  color: AppColors.red[200],
                                ),
                              ),
                              Text(
                                "\$ $price",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.red[200],
                                        fontSize: styles["price"]["size"]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                onSubmitted: (String value) {
                  widget.onChangeComments(
                      widget.product.id, widget.product.productSize, value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Comments',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

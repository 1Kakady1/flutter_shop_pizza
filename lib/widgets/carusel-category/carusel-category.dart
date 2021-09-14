import 'package:flutter/material.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/widgets/card/card_category/card_category.dart';

typedef Press = void Function(String cat);

class CaruselCategory extends StatefulWidget {
  final double? height;
  final double? separatorSize;
  final List<Category> cat;
  final int activeCat;
  final Press onPress;
  CaruselCategory(
      {Key? key,
      required this.cat,
      this.height = 230,
      this.separatorSize = 0,
      required this.onPress,
      this.activeCat = 0})
      : super(key: key);
  @override
  _CaruselCategoryState createState() => _CaruselCategoryState();
}

class _CaruselCategoryState extends State<CaruselCategory> {
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double mediaWidth = constraints.maxWidth;
      return Container(
        height: mediaWidth > 600 ? 324 : widget.height,
        padding: EdgeInsets.all(12),
        child: ListView.separated(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.cat.length,
          separatorBuilder: (context, index) =>
              SizedBox(width: widget.separatorSize),
          itemBuilder: (context, index) {
            return Container(
              child: CardCategory(
                mediaWidth: mediaWidth,
                width: mediaWidth > 600 ? 210 : 95,
                height: mediaWidth > 600 ? 324 : null,
                isActive: index == widget.activeCat,
                onPress: () {
                  widget.onPress(widget.cat[index].name);
                },
                name: widget.cat[index].name,
                preview: widget.cat[index].preview,
                margin:
                    EdgeInsets.only(left: 14, right: 14, bottom: 18, top: 10),
              ),
            );
          },
        ),
      );
    });
  }
}

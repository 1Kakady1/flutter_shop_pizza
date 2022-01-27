import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';

SnackBar snackBar(String msg,
    {bool? isLoad,
    bool? fullWidth,
    BuildContext? ctx,
    Widget? loader,
    Duration? duration,
    BorderRadius? borderRadius}) {
  final load = Row(children: [
    loader != null
        ? loader
        : CircularProgressIndicator(
            color: AppColors.red[200],
            strokeWidth: 4.0,
          ),
    SizedBox(
      width: 12,
    )
  ]);
  return SnackBar(
    content: Row(
      children: [
        isLoad == true ? load : SizedBox(),
        Expanded(flex: 1, child: Text(msg))
      ],
    ),
    duration: duration ?? Duration(milliseconds: 2000),
    width: fullWidth == true && ctx != null
        ? MediaQuery.of(ctx).size.width
        : 310.0, // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(10.0),
    ),
  );
}

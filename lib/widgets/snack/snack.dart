import 'package:flutter/material.dart';

SnackBar snackBar(String msg) {
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

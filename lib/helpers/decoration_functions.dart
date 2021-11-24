import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';

InputDecoration registerInputDecoration(
    {String? hintText, String? labelText, Widget? suffixIcon}) {
  return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
      hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.orange),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: Palette.orange),
      ),
      errorStyle: const TextStyle(color: Colors.white),
      suffixIcon: suffixIcon);
}

InputDecoration signInInputDecoration(
    {String? hintText, String? labelText, Widget? suffixIcon}) {
  return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
      hintStyle: const TextStyle(fontSize: 18),
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(width: 2, color: Palette.darkBlue),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.darkBlue),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.darkOrange),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: Palette.darkOrange),
      ),
      errorStyle: const TextStyle(color: Palette.darkOrange),
      suffixIcon: suffixIcon);
}

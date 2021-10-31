import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pizza_time/styles/colors.dart';

class InputDate extends StatelessWidget {
  final void Function(String value)? onChanged;
  final void Function(String value) onConfirm;
  final TextEditingController controller;
  final String? label;
  final String? Function(String?)? validator;
  InputDate(
      {Key? key,
      this.onChanged,
      required this.onConfirm,
      required this.controller,
      this.label,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("value date ${controller.text}");
    return Container(
      child: Stack(
        children: [
          TextFormField(
              controller: controller,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today, color: AppColors.black),
                labelText: label ?? "",
              ),
              validator: validator),
          Positioned.fill(
              child: GestureDetector(
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day + 1, 18, 00), onChanged: (date) {
                if (onChanged != null) {
                  onChanged!(date.toString());
                }
              }, onConfirm: (date) {
                onConfirm(date.toString());
              }, currentTime: DateTime.now(), locale: LocaleType.ru);
            },
            child: Container(
              child: Text(
                "Click",
                style: TextStyle(color: Colors.transparent),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

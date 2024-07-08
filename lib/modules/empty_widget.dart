import 'package:default_screen/modules/text.dart';
import 'package:flutter/material.dart';

Widget emptyWidget({required int length, required Widget child}) {
  switch (length) {
    case 0:
      return Center(child: xText("NULL", 15));
    default:
      return child;
  }
}

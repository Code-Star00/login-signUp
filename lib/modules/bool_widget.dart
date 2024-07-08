import 'package:flutter/material.dart';

Widget boolWidget({
  required bool bool,
  required Widget falseWidget,
  required Widget trueWidget,
}) {
  if (bool) {
    return trueWidget;
  } else {
    return falseWidget;
  }
}

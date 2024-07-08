import 'package:default_screen/modules/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ElevatedButton xElevatedButton({
  Key? key,
  required Function() onPressed,
  required String text,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w500,
  bool disable = false,
  ButtonStyle? style,
}) {
  return ElevatedButton(
    key: key,
    onPressed: disable
        ? null
        : () {
            HapticFeedback.selectionClick();
            onPressed();
          },
    style: style,
    child: xText(
      text,
      fontSize,
      fontWeight: fontWeight,
    ),
  );
}

import 'package:flutter/material.dart';

Text xText(
  String text,
  double size, {
  Color? color,
  FontWeight fontWeight = FontWeight.w400,
  int? maxLines = 1,
  TextOverflow? textOverflow = TextOverflow.ellipsis,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),
    maxLines: maxLines,
    overflow: textOverflow,
    textAlign: textAlign,
  );
}

SelectableText xSelectableText(
  String text,
  double size, {
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return SelectableText(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

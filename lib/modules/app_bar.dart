import 'package:default_screen/modules/text.dart';
import 'package:flutter/material.dart';

AppBar xAppBar({
  bool automaticallyImplyLeading = true,
  bool centerTitle = true,
  required String title,
  double titleFontSize = 15,
  FontWeight titleFontWeight = FontWeight.bold,
  List<Widget>? actions,
}) {
  return AppBar(
    elevation: 0,
    centerTitle: centerTitle,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: xText(
      title,
      titleFontSize,
      fontWeight: titleFontWeight,
    ),
    actions: actions,
  );
}

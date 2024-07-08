import 'package:flutter/material.dart';

SingleChildScrollView xScrollView({
  required Widget child,
  ScrollController? controller,
  ScrollPhysics? physics = const BouncingScrollPhysics(),
}) {
  return SingleChildScrollView(
    physics: physics,
    controller: controller,
    child: child,
  );
}

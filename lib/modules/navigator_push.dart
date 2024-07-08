import 'package:flutter/material.dart';

xPush(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return screen;
    },
  ));
}

// rxPush<T>(
//   Widget screen,
//   InstanceBuilderCallback<T> viewModel, {
//   Function()? func,
//   Transition? transition = Transition.native,
// }) {
//   Get.to(
//     () => screen,
//     binding: BindingsBuilder(
//       () {
//         if (func != null) {
//           func();
//         }
//         Get.lazyPut<T>(() => viewModel());
//       },
//     ),
//     transition: transition,
//   );
// }

void xPushReplace(BuildContext context, Widget screen) {
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return screen;
    },
  ));
}

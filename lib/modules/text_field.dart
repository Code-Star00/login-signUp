import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField xTextField({
  required TextEditingController controller,
  FocusNode? focusNode,
  TextInputType? textInputType,
  bool obscureText = false,
  bool enabled = true,
  List<TextInputFormatter>? inputFormatter,
  required String label,
  String? errorText,
  Widget? suffixIcon,
  Function()? onChanged,
  Function()? onEditingComplete,
}) {
  return TextField(
    controller: controller,
    focusNode: focusNode,
    keyboardType: textInputType,
    obscureText: obscureText,
    enabled: enabled,
    inputFormatters: inputFormatter,
    decoration: InputDecoration(
      labelText: label,
      filled: enabled ? false : true,
      errorText: errorText == '' ? null : errorText,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(),
    ),
    onChanged: (value) {
      if (onChanged != null) {
        onChanged();
      }
    },
    onEditingComplete: () {
      if (onEditingComplete != null) {
        onEditingComplete();
      }
    },
  );
}

// TextField getXTextField({
//   required Rx<TextEditingController> controller,
//   FocusNode? focusNode,
//   TextInputType? textInputType,
//   bool obscureText = false,
//   List<TextInputFormatter>? inputFormatter,
//   required String hint,
//   String? errorText,
//   Widget? suffixIcon,
//   Function()? onChanged,
//   Function()? onEditingComplete,
// }) {
//   return TextField(
//     controller: controller,
//     focusNode: focusNode,
//     keyboardType: textInputType,
//     obscureText: obscureText,
//     inputFormatters: inputFormatter,
//     decoration: InputDecoration(
//       hintText: hint,
//       filled: true,
//       errorText: errorText,
//       suffixIcon: suffixIcon,
//     ),
//     onChanged: (value) {
//       if (onChanged != null) {
//         onChanged();
//       }
//     },
//     onEditingComplete: () {
//       if (onEditingComplete != null) {
//         onEditingComplete();
//       }
//     },
//   );
// }

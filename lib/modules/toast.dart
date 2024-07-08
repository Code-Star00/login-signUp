import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required String text, required Color textColor, required Color backGroundColor}) {
  Fluttertoast.showToast(
    msg: text,
    textColor: textColor,
    backgroundColor: backGroundColor,
  );
}

showResponseToast({required String code, required String text}) {
  Fluttertoast.showToast(
    msg: text,
    textColor: Colors.white,
    backgroundColor: code == 'S' ? Colors.deepPurple : Colors.red,
  );
}

showSuccessToast({required String text}) {
  Fluttertoast.showToast(
    msg: text,
    textColor: Colors.white,
    backgroundColor: Colors.deepPurple,
  );
}

showErrorToast({required String text}) {
  Fluttertoast.showToast(
    msg: text,
    textColor: Colors.white,
    backgroundColor: Colors.red,
    timeInSecForIosWeb: 3,
  );
}

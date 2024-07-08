import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool pwObscure = true;

  bool isAutoLogin = false;
  bool? isSaveEmail = false;

  Function(bool?)? saveEmailChanged;
  Function(bool?) setAutoLogin = (bool? value) {};

  noti() => notifyListeners();
}

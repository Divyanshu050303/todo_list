import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  bool show = false;

  void showOption() {
    show != show;
    notifyListeners();
  }
}

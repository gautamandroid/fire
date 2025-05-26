import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToastDialog {
  static void toast(String? value,
      {ToastGravity? gravity, length = Toast.LENGTH_SHORT,
        Color? bgColor, Color? textColor, bool log = false}) {
    if (value!.isEmpty) {
      print(value);
    } else {
      Fluttertoast.showToast(msg: value, gravity: gravity, toastLength: length, backgroundColor: bgColor, textColor: textColor);
      if (log) print(value);
    }
  }
}

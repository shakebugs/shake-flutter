import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Messages {
  static show(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        fontSize: 16.0);
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMsg(String message,[bool error = false]) {
  Fluttertoast.showToast(msg: message,
      textColor: Colors.white,backgroundColor: error ? Colors.red : Color(0xFF1a315d));
}
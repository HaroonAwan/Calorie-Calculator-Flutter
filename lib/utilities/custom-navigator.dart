import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigator {
  static navigateTo(context, widget) {
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => widget)
    );
  }

  static pushReplacement(context,widget){
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => widget),(Route<dynamic> route) => false);
  }


}
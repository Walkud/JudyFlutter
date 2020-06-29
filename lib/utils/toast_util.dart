
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast 工具类
class JudyToast{
  static void showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Color(0x66000000),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
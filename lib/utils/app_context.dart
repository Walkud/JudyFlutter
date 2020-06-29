
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppContext{
  static const bool isRelease = const bool.fromEnvironment("dart.vm.product");

  static getSystemUiOverlayDarkStyle(){
    return SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
  }

  static getSystemUiOverlayLightStyle(){
    return SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
  }
}
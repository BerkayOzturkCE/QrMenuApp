import 'dart:ffi';

import 'package:flutter/material.dart';

class ScreenUtil {
  static getSize(context) {
    return MediaQuery.of(context).size;
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static minimumSize(context) {
    double enkucuk = getWidth(context);
    if (getWidth(context) > getHeight(context)) {
      enkucuk = getHeight(context);
    }
    return enkucuk;
  }

  static divideWidth(context, {divided = 1}) {
    return MediaQuery.of(context).size.width / divided;
  }
}

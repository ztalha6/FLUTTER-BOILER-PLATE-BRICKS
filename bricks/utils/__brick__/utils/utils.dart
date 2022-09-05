import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static final Utils _singleton = Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  void clearKeyboardFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  bool isNotNull(dynamic object) {
    return object != null ? true : false;
  }
}

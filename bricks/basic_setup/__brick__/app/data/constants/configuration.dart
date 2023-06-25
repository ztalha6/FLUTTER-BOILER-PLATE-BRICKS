import 'package:flutter/material.dart';

class Configuration {
  static final Configuration _singleton = Configuration._internal();

  factory Configuration() {
    return _singleton;
  }

  Configuration._internal();

  /*
  Key is defined in following files
  1. Mainfiest file
  2. AppDelegate.swift file
  */
  String mapKey = "AIzaSyCNw8p8lAjSGYr2GzQnkqwcBlEJs2tQ4cc";
  /* The given logo with image by any brand  */
  String logoWithName = 'assets/logo/logo_with_name.png';
  String logoNetworkUrl = 'assets/images/logo_with_name.png';
  Color primaryColor = const Color(0xFF5ADDD4);
  Color secondaryColor = const Color(0xFF7087F6);
  String currency = 'Rs. ';
}

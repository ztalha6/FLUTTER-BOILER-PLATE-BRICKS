import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarManager {
  void showSuccessSnackbar(String message) {
    Get.snackbar(
      '',
      '',
      backgroundColor: Theme.of(Get.context!).primaryColor,
      titleText: Container(),
      borderRadius: 0,
      messageText: Row(
        children: [
          Expanded(
              child: Text(
            message,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          )),
        ],
      ),
      duration: const Duration(seconds: 2),
    );
  }

  void showAlertSnackbar(String message,
      {String? buttonText, void Function()? buttonOnPressed}) {
    Get.snackbar(
      '',
      '',
      backgroundColor: Color(0xffFF5C5C),
      titleText: Container(),
      borderRadius: 0,
      messageText: Row(
        children: [
          Expanded(
              child: Text(
            message,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          )),
        ],
      ),
      mainButton: buttonText != null
          ? TextButton(
              onPressed: buttonOnPressed,
              child: Text(buttonText),
            )
          : null,
      duration: const Duration(seconds: 2),
    );
  }

  void showInfoSnackbar(String message,
      {String? buttonText, void Function()? buttonOnPressed}) {
    Get.snackbar(
      '',
      '',
      boxShadows: [
        const BoxShadow(color: Colors.black, spreadRadius: 10, blurRadius: 100),
      ],
      backgroundColor: Colors.white,
      titleText: Container(),
      messageText: Row(
        children: [
          Icon(
            CupertinoIcons.info_circle,
            size: 30,
            color: Theme.of(Get.context!).primaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(message)),
        ],
      ),
      mainButton: buttonText != null
          ? TextButton(
              onPressed: buttonOnPressed,
              child: Text(buttonText),
            )
          : null,
      duration: const Duration(seconds: 2),
    );
  }
}

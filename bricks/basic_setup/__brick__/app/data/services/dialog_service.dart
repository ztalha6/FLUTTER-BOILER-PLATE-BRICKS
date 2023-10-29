import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService {
  Future<bool?> showConfirmationDialog({
    required String title,
    required String description,
    Color yesButtonColor = Colors.black,
    bool onlyOK = false,
  }) {
    final Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: Theme.of(Get.context!).textTheme.titleLarge,
      ),
      onPressed: () {
        Get.back(result: false);
      },
    );
    final Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge!
            .copyWith(color: yesButtonColor),
      ),
      onPressed: () {
        Get.back(result: true);
      },
    );

    return Platform.isAndroid
        ? showDialog<bool>(
            context: Get.context!,
            barrierColor: Colors.white.withOpacity(0.1),
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  title,
                  style: Theme.of(Get.context!).textTheme.titleLarge,
                ),
                content: Text(
                  description,
                  style: Theme.of(Get.context!).textTheme.headlineMedium,
                ),
                actions: [
                  cancelButton,
                  continueButton,
                ],
              );
            },
          )
        : showCupertinoDialog<bool>(
            context: Get.context!,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: Theme.of(Get.context!).textTheme.titleLarge,
                  ),
                ),
                content: Text(
                  description,
                  style: Theme.of(Get.context!).textTheme.headlineMedium,
                ),
                actions: [
                  cancelButton,
                  continueButton,
                ],
              );
            },
          );
  }
}

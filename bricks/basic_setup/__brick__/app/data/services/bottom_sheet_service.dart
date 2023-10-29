import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dialog_service.dart';

class BottomSheetService {
  static final BottomSheetService _singleton = BottomSheetService._internal();

  factory BottomSheetService() {
    return _singleton;
  }

  BottomSheetService._internal();

  void showEditDeleteBottomSheet({
    required Function() onEditTap,
    required Function() onDeleteTap,
    List<Widget> moreOptions = const [],
  }) {
    Get.bottomSheet(
      Wrap(
        children: <Widget>[
          Container(
            //height: 150,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            //width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: Platform.isIOS,
                        maintainState: true,
                        maintainSize: true,
                        maintainAnimation: true,
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: Theme.of(Get.context!).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 55),
                    Expanded(
                      child: Text(
                        'Select Option',
                        style: Theme.of(Get.context!).textTheme.titleLarge,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  dense: true,
                  onTap: onEditTap,
                  title: Text(
                    'Edit',
                    textScaleFactor: 1.2,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .bodyMedium!
                        .copyWith(height: 2, color: Colors.black),
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () async {
                    final bool result =
                        await DialogService().showConfirmationDialog(
                              title: "Confirm delete",
                              description:
                                  'Are you sure you want to delete this?',
                            ) ??
                            false;
                    if (result) onDeleteTap();
                  },
                  title: Text(
                    'Delete',
                    textScaleFactor: 1.2,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .bodyMedium!
                        .copyWith(height: 2, color: Colors.black),
                  ),
                ),
                ...moreOptions
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showContent({
    required Widget content,
  }) {
    Get.bottomSheet(
      Wrap(
        children: <Widget>[
          Container(
            //height: 150,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            //width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                content,
              ],
            ),
          ),
        ],
      ),
      isScrollControlled: true,
    );
  }
}

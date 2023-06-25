import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:{{#pascalCase}}{{projectName}}{{/pascalCase}}/app/routes/app_pages.dart';

import '../../../../data/constants/configuration.dart';
import '../../../../data/env/env.dart';
import '../../create_password/views/create_password_view.dart';

class VerifyOtpController extends GetxController {
  Configuration configs = Configuration();
  TextEditingController otpController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isResending = false.obs;

  @override
  void onInit() {
    startTimer();
    if (Env.currentEnv.user != null) {
      otpController.text = '0000';
    }
    super.onInit();
  }

  Rxn<Timer>? timer = Rxn();

  // RxInt minutes = RxInt(1);

  RxInt start = RxInt(60);

  void startTimer() {
    // codeSentCount++;
    start.value = 30;
    // minutes.value = 1;
    const oneSec = Duration(seconds: 1);
    timer!.value = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          // notifyListeners();
        } else {
          // if (start.value == 0) {
          //   minutes.value -= 1;
          //   start.value = 60;
          // }
          if (start.value > 0) {
            start.value--;
            // notifyListeners();
          }
        }
      },
    );
  }

  Future<void> onVerifyTap({
    bool fromSignUp = false,
    bool fromSignIn = false,
  }) async {
    if (otpController.text.isEmpty) return;
    isLoading.value = true;
    const bool response = true;
    await Future.delayed(3.seconds);
    // await AuthRepository().verifyOtp(otpController.text);
    if (response) {
      if (fromSignUp) {
        Get.offAllNamed(Routes.POST_SIGN_UP);
      } else if (fromSignIn) {
        Get.offAllNamed(Routes.HOME);
      } else {
        debugPrint("Auto: ${otpController.text}");
        Get.offAndToNamed(
          Routes.CREATE_PASSWORD,
          arguments: CreatePasswordViewParams(
            isChangingPassword: false,
            otp: otpController.text,
          ),
        );
      }
    }
    isLoading.value = false;
  }

  Future<void> resendOtp() async {
    isResending.value = true;
    // if (await AuthRepository()
    //     .sendOtp((await UserManager().getUser())!.email!)) {
    startTimer();
    // }
    isResending.value = false;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/env/env.dart';
import '../../../../data/services/validator_service.dart';
import '../../../../routes/app_pages.dart';

class ForgetPassswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxnString emailErrorText = RxnString();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (Env.currentEnv.user != null) {
      emailController.text = Env.currentEnv.user!.email;
      // onSignInTap();
    }
    super.onInit();
  }

  Future<void> onRecoverNowTap() async {
    final bool isValid = checkForValidation();
    if (!isValid) return;
    isLoading.value = true;
    // if (await AuthRepository().sendOtp(emailController.text)) {
    //   await UserManager().saveUser(User(email: emailController.text));
    Get.offAndToNamed(
      Routes.VERIFY_OTP,
      arguments: [false, false, emailController.text],
    );
    // }
    isLoading.value = false;
  }

  bool checkForValidation() {
    emailErrorText.value = Validator().validateEmail(emailController.text);
    return emailErrorText.value == null;
  }
}

import 'package:app_essentials/app/data/model/user_model.dart';
import 'package:app_essentials/app/data/repositories/auth_repository.dart';
import 'package:app_essentials/app/data/services/user_manager.dart';
import 'package:app_essentials/app/data/services/validator_service.dart';
import 'package:app_essentials/core/env/env_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class ForgetPassswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxnString emailErrorText = RxnString();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (Environment.currentEnv.user != null) {
      emailController.text = Environment.currentEnv.user!.email;
      // onSignInTap();
    }
    super.onInit();
  }

  Future<void> onRecoverNowTap() async {
    final bool isValid = checkForValidation();
    if (!isValid) return;
    isLoading.value = true;
    if (await AuthRepository().sendOtp(emailController.text)) {
      await UserManager().saveUser(User(email: emailController.text));
      Get.offAndToNamed(
        Routes.VERIFY_OTP,
        arguments: [false, false, emailController.text],
      );
    }
    isLoading.value = false;
  }

  bool checkForValidation() {
    emailErrorText.value = Validator().validateEmail(emailController.text);
    return emailErrorText.value == null;
  }
}

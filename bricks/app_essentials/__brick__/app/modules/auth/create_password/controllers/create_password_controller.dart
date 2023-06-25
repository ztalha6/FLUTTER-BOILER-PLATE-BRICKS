import 'package:app_essentials/app/data/repositories/auth_repository.dart';
import 'package:app_essentials/app/data/services/validator_service.dart';
import 'package:app_essentials/core/env/env_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/create_password_view.dart';

class CreatePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxnString oldPasswordErrorText = RxnString();
  RxnString passwordErrorText = RxnString();
  RxnString confirmPasswordErrorText = RxnString();
  RxBool isLoading = false.obs;
  CreatePasswordViewParams params = CreatePasswordViewParams(otp: '');
  Validator validator = Validator();

  @override
  void onInit() {
    params = Get.arguments ?? CreatePasswordViewParams(otp: "");
    if (Environment.currentEnv.user != null) {
      passwordController.text = Environment.currentEnv.user!.password;
      confirmPasswordController.text = Environment.currentEnv.user!.password;
    }
    super.onInit();
  }

  Future<void> onUpdatePasswordTap() async {
    final bool isValid = checkErrors();
    if (!isValid) return;
    isLoading.value = true;
    if (params.isChangingPassword
        ? await AuthRepository().changePassword(
            passwordController.text,
            confirmPasswordController.text,
            oldPasswordController.text,
          )
        : await AuthRepository().resetPassword(
            passwordController.text,
            confirmPasswordController.text,
            params.otp,
          )) {
      Get.back();
    }
    isLoading.value = false;
  }

  bool checkErrors() {
    oldPasswordErrorText.value = null;
    passwordErrorText.value = null;
    confirmPasswordErrorText.value = null;
    final List<String?> errors = validator.validatePasswords(
      passwordController.text,
      confirmPasswordController.text,
      withOldPassword: params.isChangingPassword,
      oldPassword: oldPasswordController.text,
    );
    if (params.isChangingPassword) {
      oldPasswordErrorText.value = errors[0];
      passwordErrorText.value = errors[1];
      confirmPasswordErrorText.value = errors[2];
    } else {
      passwordErrorText.value = errors[0];
      confirmPasswordErrorText.value = errors[1];
    }
    if (params.isChangingPassword) {
      return passwordErrorText.value == null &&
          confirmPasswordErrorText.value == null &&
          oldPasswordErrorText.value == null;
    }
    return passwordErrorText.value == null &&
        confirmPasswordErrorText.value == null;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/env/env.dart';
import '../../../../data/services/validator_service.dart';
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
    if (Env.currentEnv.user != null) {
      passwordController.text = Env.currentEnv.user!.password;
      confirmPasswordController.text = Env.currentEnv.user!.password;
    }
    super.onInit();
  }

  Future<void> onUpdatePasswordTap() async {
    final bool isValid = checkErrors();
    if (!isValid) return;
    isLoading.value = true;
    await Future.delayed(2.seconds);
    // if (params.isChangingPassword
    //     ? await AuthRepository().changePassword(
    //         passwordController.text,
    //         confirmPasswordController.text,
    //         oldPasswordController.text,
    //       )
    //     : await AuthRepository().resetPassword(
    //         passwordController.text,
    //         confirmPasswordController.text,
    //         params.otp,
    //       )) {
    Get.back();
    // }
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

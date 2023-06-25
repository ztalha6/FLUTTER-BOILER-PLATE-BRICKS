// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:app_essentials/app/data/config/app_configuration.dart';
import 'package:app_essentials/app/data/model/user_model.dart';
import 'package:app_essentials/app/data/repositories/auth_repository.dart';
import 'package:app_essentials/app/data/services/validator_service.dart';
import 'package:app_essentials/app/data/utils/utils.dart';
import 'package:app_essentials/core/env/env_setup.dart';
import 'package:app_essentials/core/model/repository_response_model.dart';

import '../../../../routes/app_pages.dart';

class SignInController extends GetxController {
  Configuration configs = Configuration();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxnString emailErrorText = RxnString();
  RxnString passwordErrorText = RxnString();
  RxBool isLoading = false.obs;
  RxBool isPerformingGoogleSignIn = false.obs;
  RxBool isPerformingAppleSignIn = false.obs;
  RxBool isPerformingFacebookSignIn = false.obs;
  RxBool isPerformingGuestSignIn = false.obs;

  Validator validator = Validator();

  @override
  void onInit() {
    if (Environment.currentEnv.user != null) {
      emailController.text = Environment.currentEnv.user!.email;
      passwordController.text = Environment.currentEnv.user!.password;
      // onSignInTap();
    }
    super.onInit();
  }

  Future<void> onSignInTap() async {
    Utils().clearKeyboardFocus();
    final bool isValid = checkForError();
    if (!isValid) return;
    isLoading.value = true;
    final RepositoryResponse<User> response = await AuthRepository()
        .signIn(emailController.text, passwordController.text);
    if (response.isSuccess) {
      if (!response.data!.verified) {
        Get.offAllNamed(
          Routes.VERIFY_OTP,
          arguments: [false, true, emailController.text],
        );
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    }

    isLoading.value = false;
  }

  // Future<void> onGuestButtonTap() async {
  //   isPerformingGuestSignIn(true);
  //   final RepositoryResponse<User> response =
  //       await AuthRepository().guestSignIn();
  //   if (response.isSuccess) {
  //     Get.offAllNamed(Routes.HOME);
  //   }

  //   isPerformingGuestSignIn(false);
  // }

  Future<void> doGoogleSignIn() async {
    isPerformingGoogleSignIn(true);
    try {
      final GoogleSignInAccount? creds = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication auth = await creds!.authentication;
      if (await AuthRepository().googleSignIn(creds, auth.accessToken!)) {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      isPerformingGoogleSignIn(false);
    }
    isPerformingGoogleSignIn(false);
  }

  Future<void> doFacebookSignIn() async {
    isPerformingFacebookSignIn(true);
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'public_profile',
        'email',
        'pages_show_list',
        'pages_messaging',
        'pages_manage_metadata'
      ],
    );

    if (result.status == LoginStatus.success) {
      // you are logged
      //TODO: to be used in facebook login
      // final AccessToken accessToken = result.accessToken!;
    } else {
      debugPrint(result.status.toString());
      debugPrint(result.message);
    }
    isPerformingFacebookSignIn(false);
  }

  Future<void> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // Provide your own nonce here.
        nonce: 'nonce',
      );

      if (credential.email == null) {
        debugPrint('No email associated with this Apple ID.');
      }

      // Use the appleIdToken, email, and fullName to sign in or create a new account.
      if (await AuthRepository().appleLogin(credential)) {
        Get.offAllNamed(Routes.HOME);
      }
    } on PlatformException catch (error) {
      debugPrint(error.message);
    }
  }

  bool checkForError() {
    emailErrorText.value = null;
    passwordErrorText.value = null;
    emailErrorText.value = validator.validateEmail(emailController.text);
    passwordErrorText.value =
        validator.validatePassword(passwordController.text);
    return emailErrorText.value == null && passwordErrorText.value == null;
  }
}

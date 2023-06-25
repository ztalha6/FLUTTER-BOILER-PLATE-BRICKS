import 'dart:io';

import 'package:app_essentials/app/data/config/asset_constants.dart';
import 'package:app_essentials/app/data/widgets/custom_expandable_appbar.dart';
import 'package:app_essentials/app/data/widgets/custom_text_form_field.dart';
import 'package:app_essentials/app/data/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignInController());
    return GetX<SignInController>(
      builder: (model) {
        debugPrint(model.isLoading.toString());
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomExpandedAppBar(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 26),
                        ),
                        SizedBox(height: 5.h),
                        CustomTextFormField(
                          label: 'Email',
                          errorText: model.emailErrorText.value,
                          controller: model.emailController,
                          hintText: "Enter email address",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 2.h),
                        CustomTextFormField(
                          label: 'Password',
                          errorText: model.passwordErrorText.value,
                          controller: model.passwordController,
                          hintText: "Enter Password",
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onDone: (s) => model.onSignInTap(),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () =>
                                  Get.toNamed(Routes.FORGET_PASSSWORD),
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 16,
                                      color: model.configs.secondaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        PrimaryButton(
                          isLoading: model.isLoading.value,
                          text: 'Sign In',
                          textStyle:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                          onTap: () => model.onSignInTap(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('____' * 4),
                              SizedBox(width: 2.w),
                              Transform.translate(
                                offset: const Offset(0, 6),
                                child: Text(
                                  'or',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontSize: 16),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text('____' * 4),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: Platform.isIOS,
                          child: PrimaryButton(
                            buttonColor: Colors.white,
                            isLoading: controller.isPerformingAppleSignIn.value,
                            text: 'Countinue with Apple',
                            borderColor: Colors.black,
                            leadingWidget: const Icon(
                              Icons.apple,
                              size: 30,
                            ),
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                            onTap: () => model.signInWithApple(),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        PrimaryButton(
                          buttonColor: Colors.white,
                          isLoading: controller.isPerformingGoogleSignIn.value,
                          text: 'Countinue with Goolge',
                          borderColor: const Color(0xFFD9D9D9),
                          leadingWidget: Image.asset(
                            googleLogo,
                            scale: 3,
                          ),
                          textStyle: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: 16,
                                color: const Color(0xFF757575),
                              ),
                          onTap: () => model.doGoogleSignIn(),
                        ),
                        SizedBox(height: 2.h),
                        PrimaryButton(
                          borderColor: const Color(0xFF1877F2),
                          buttonColor: Colors.transparent,
                          isLoading:
                              controller.isPerformingFacebookSignIn.value,
                          text: 'Countinue with Facebook',
                          leadingWidget: Image.asset(
                            facebookLogo,
                            scale: 3,
                            color: const Color(0xFF1877F2),
                          ),
                          textStyle: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: 16,
                                color: const Color(0xFF1877F2),
                              ),
                          onTap: () => model.doFacebookSignIn(),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Not registered yet? \n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sign up',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: model.configs.secondaryColor,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(Routes.SIGN_UP);
                                        },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

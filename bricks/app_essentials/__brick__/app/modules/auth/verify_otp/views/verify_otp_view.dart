import 'package:app_essentials/app/data/widgets/custom_expandable_appbar.dart';
import 'package:app_essentials/app/data/widgets/custom_pin_code_field.dart';
import 'package:app_essentials/app/data/widgets/loading_widget.dart';
import 'package:app_essentials/app/data/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  final String email;
  final bool fromSignUp;
  final bool fromSignIn;
  const VerifyOtpView({
    Key? key,
    required this.fromSignUp,
    required this.fromSignIn,
    required this.email,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<VerifyOtpController>(
      builder: (model) {
        return Scaffold(
          body: CustomExpandedAppBar(
            child: Container(
              height: Get.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Verification',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      children: [
                        Text(
                          'Please enter the OTP you recived to ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.033,
                    ),
                    Center(
                      child: SizedBox(
                        width: Get.width / 1.5,
                        child: CustomPinCodeField(
                          controller: model.otpController,
                          validator: (s) =>
                              s!.isEmpty ? 'Field cannot be empty' : null,
                          onCompleted: (s) => model.onVerifyTap(
                            fromSignUp: fromSignUp,
                            fromSignIn: fromSignIn,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (model.start.value != 0)
                          RichText(
                            text: TextSpan(
                              text: "Expires in: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 16,
                                    color: const Color(0xFF707581),
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${model.start} sec',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 16,
                                        color: model.configs.secondaryColor,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await model.resendOtp();
                                    },
                                )
                              ],
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.048,
                    ),
                    if (model.isLoading.isTrue)
                      Center(
                        child: Column(
                          children: [
                            const LoadingWidget(),
                            SizedBox(height: 2.h),
                            Text(
                              "Verifying OTP",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    else
                      PrimaryButton(
                        onTap: () => model.onVerifyTap(
                          fromSignUp: fromSignUp,
                          fromSignIn: fromSignIn,
                        ),
                        text: 'Verify',
                        isLoading: model.isLoading.value,
                        isDisabled: model.isResending.isTrue,
                        textStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Didn't receive code?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Resend',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: model.configs.secondaryColor,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await model.resendOtp();
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
            ),
          ),
        );
      },
    );
  }
}

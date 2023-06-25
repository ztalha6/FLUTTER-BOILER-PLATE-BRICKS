import 'package:app_essentials/app/data/widgets/custom_expandable_appbar.dart';
import 'package:app_essentials/app/data/widgets/custom_text_form_field.dart';
import 'package:app_essentials/app/data/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/forget_passsword_controller.dart';

class ForgetPassswordView extends GetView<ForgetPassswordController> {
  const ForgetPassswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ForgetPassswordController>(
      builder: (controller) {
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
                      'Forgot Password',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      children: [
                        Text(
                          'Enter email address to receive a 4 digit code for verification',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      label: 'Email',
                      errorText: controller.emailErrorText.value,
                      controller: controller.emailController,
                      hintText: "Enter email address",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onDone: (s) => controller.onRecoverNowTap(),
                    ),
                    SizedBox(
                      height: Get.height * 0.078,
                    ),
                    PrimaryButton(
                      onTap: () => controller.onRecoverNowTap(),
                      text: 'Continue',
                      isLoading: controller.isLoading.value,
                      textStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                    )
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

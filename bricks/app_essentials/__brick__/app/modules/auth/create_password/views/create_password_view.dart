import 'package:app_essentials/app/data/widgets/custom_expandable_appbar.dart';
import 'package:app_essentials/app/data/widgets/custom_text_form_field.dart';
import 'package:app_essentials/app/data/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/create_password_controller.dart';

class CreatePasswordViewParams {
  final bool isChangingPassword;
  final String otp;

  CreatePasswordViewParams({
    this.isChangingPassword = true,
    required this.otp,
  });
}

class CreatePasswordView extends GetView<CreatePasswordController> {
  const CreatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<CreatePasswordController>(
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
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create new Password',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      children: [
                        Text(
                          'Your new password must be different from the previously used passwords',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Visibility(
                      visible: model.params.isChangingPassword,
                      child: CustomTextFormField(
                        label: 'Old Password',
                        errorText: model.oldPasswordErrorText.value,
                        controller: model.oldPasswordController,
                        hintText: "Enter old Password",
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      errorText: model.passwordErrorText.value,
                      controller: model.passwordController,
                      hintText: "Enter Password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                      label: 'Confirm Password',
                      errorText: model.confirmPasswordErrorText.value,
                      controller: model.confirmPasswordController,
                      hintText: "Enter Password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: Get.height * 0.078,
                    ),
                    PrimaryButton(
                      onTap: () => model.onUpdatePasswordTap(),
                      text: 'Update Password',
                      isLoading: model.isLoading.value,
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

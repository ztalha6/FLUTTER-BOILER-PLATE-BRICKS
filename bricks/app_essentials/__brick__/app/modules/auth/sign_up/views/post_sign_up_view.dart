import 'package:app_essentials/app/data/widgets/custom_dropdown_field.dart';
import 'package:app_essentials/app/data/widgets/custom_text_form_field.dart';
import 'package:app_essentials/app/data/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import '../controllers/post_sign_up_controller.dart';

class PostSignUpView extends StatelessWidget {
  const PostSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<PostSignUpController>(
      init: Get.put(PostSignUpController()),
      builder: (model) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          appBar: AppBar(
            toolbarHeight: 10.h,
            backgroundColor: Colors.white,
            title: Text(
              'Manage your Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            elevation: 0.5,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropDown<String>(
                          label: "Sex",
                          items: const [
                            'Male',
                            'Female',
                          ],
                          selectedValue: model.selectedGender.value,
                          onChangeCallback: (value) {
                            model.selectedGender(value);
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomDropDown<String>(
                          label: "Age",
                          items: const [
                            '17 Years',
                            '18 Years',
                          ],
                          selectedValue: model.selectedAge.value,
                          onChangeCallback: (value) {
                            model.selectedAge(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isMandatory: true,
                    label: 'Condition',
                    // errorText: model.lastNameErrorText.value,
                    // controller: model.lastnameController,
                    hintText: "Enter your condition",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isMandatory: true,
                    label: 'Caregiver',
                    // errorText: model.lastNameErrorText.value,
                    // controller: model.lastnameController,
                    hintText: "Enter your caregiver",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isMandatory: true,
                    label: 'Address',
                    // errorText: model.lastNameErrorText.value,
                    // controller: model.lastnameController,
                    hintText: "Enter your address",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isMandatory: true,
                    label: 'Country',
                    // errorText: model.emailErrorText.value,
                    // controller: model.emailController,
                    hintText: "Enter your country",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isMandatory: true,
                    label: 'City',
                    // errorText: model.passwordErrorText.value,
                    // controller: model.passwordController,
                    hintText: "Enter your city",
                    keyboardType: TextInputType.text,
                    // onDone: (s) => model.onSignInTap(),
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isMandatory: true,
                    label: 'State',
                    // errorText: model.passwordErrorText.value,
                    // controller: model.passwordController,
                    hintText: "Enter your state",
                    keyboardType: TextInputType.text,
                    // onDone: (s) => model.onSignInTap(),
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isMandatory: true,
                    label: 'ZIP Code',
                    // errorText: model.passwordErrorText.value,
                    // controller: model.passwordController,
                    hintText: "Enter your ZIP Code",
                    keyboardType: TextInputType.text,
                    // onDone: (s) => model.onSignInTap(),
                  ),
                  SizedBox(height: 5.h),
                  PrimaryButton(
                    isLoading: model.isLoading.value,
                    text: 'Next',
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                    onTap: () => model.onNextTap(),
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

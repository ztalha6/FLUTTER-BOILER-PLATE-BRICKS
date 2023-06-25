import 'package:app_essentials/app/data/widgets/custom_expandable_appbar.dart';
import 'package:app_essentials/app/data/widgets/custom_phone_field.dart';
import 'package:app_essentials/app/data/widgets/custom_text_form_field.dart';
import 'package:app_essentials/app/data/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SignUpController>(
      builder: (model) {
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 24),
                    ),
                    SizedBox(height: 5.h),

                    if (model.image.value == null)
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            Padding(
                              padding: const EdgeInsets.all(36.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        model.onChangePhotoTapped(
                                          camera: true,
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.camera,
                                            size: 50,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Text(
                                            'Camera'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        model.onChangePhotoTapped();
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 50,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Text(
                                            'Gallery'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            elevation: 20.0,
                            enableDrag: false,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: model.configuration.secondaryColor
                              .withOpacity(0.2),
                          radius: 50,
                          child: Icon(
                            Icons.camera_alt,
                            color: model.configuration.secondaryColor,
                          ),
                        ),
                      )
                    else
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: model.image.value!,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  Padding(
                                    padding: const EdgeInsets.all(36.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              model.onChangePhotoTapped(
                                                camera: true,
                                              );
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.camera,
                                                  size: 50,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                Text(
                                                  'Camera'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              model.onChangePhotoTapped();
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.image,
                                                  size: 50,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                Text(
                                                  'Gallery'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  elevation: 20.0,
                                  enableDrag: false,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    model.configuration.primaryColor,
                                radius: 20,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    // ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            isMandatory: true,
                            label: 'First Name',
                            errorText: model.firstNameErrorText.value,
                            controller: model.firstnameController,
                            hintText: "Enter First Name",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFormField(
                            isMandatory: true,
                            label: 'Last Name',
                            errorText: model.lastNameErrorText.value,
                            controller: model.lastnameController,
                            hintText: "Enter Last Name",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      isMandatory: true,
                      label: 'Date of Birth',
                      errorText: model.dobErrorText.value,
                      controller: model.dobController,
                      hintText: "Enter Date of Birth",
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      suffixIcon: IconButton(
                        onPressed: () {
                          model.selectDate(context);
                        },
                        icon: const Icon(
                          Icons.date_range_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      isMandatory: true,
                      label: 'Email',
                      errorText: model.emailErrorText.value,
                      controller: model.emailController,
                      hintText: "Enter email address",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 2.h),
                    CustomPhoneField(
                      onInputChanged: (number) {
                        model.phone.value = number;
                      },
                      controller: model.phoneController,
                      errorText: model.phoneErrorText.value,
                      label: 'Phone',
                      hintText: 'Enter Phone Number',
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      isMandatory: true,
                      label: 'Password',
                      errorText: model.passwordErrorText.value,
                      controller: model.passwordController,
                      hintText: "Enter Password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onDone: (s) => model.onSignInTap(),
                    ),
                    SizedBox(height: 5.h),
                    PrimaryButton(
                      isLoading: model.isLoading.value,
                      text: 'Sign Up',
                      textStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                      onTap: () => model.onSignInTap(),
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
                              text: 'Have an account? \n',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign In',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: model.configs.secondaryColor,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offAllNamed(Routes.SIGN_IN);
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

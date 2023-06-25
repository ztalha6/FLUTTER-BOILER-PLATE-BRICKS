import 'package:app_essentials/app/data/config/asset_constants.dart';
import 'package:app_essentials/app/data/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<OnboardingController>(
      builder: (model) {
        debugPrint(model.visible.toString());
        return Center(
          child: Scaffold(
            backgroundColor: model.configs.secondaryColor,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.55,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(onboardingImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        'My Medical Planner',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Discover food from your near by branches..',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: Get.height * 0.041),
                      PrimaryButton(
                        text: 'Create an Account',
                        textStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Colors.white,
                                ),
                        onTap: () => Get.offAllNamed(Routes.SIGN_UP),
                      ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        text: 'Already a Member?',
                        buttonColor: Colors.white,
                        textStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(),
                        onTap: () => Get.toNamed(Routes.SIGN_IN),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

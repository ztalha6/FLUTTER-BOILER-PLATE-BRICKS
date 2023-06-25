import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SplashController model = Get.put(SplashController());
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              model.configs.logoWithName,
              scale: 3,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 34.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetX<SplashController>(
                    builder: (model) {
                      return Text(
                        "Version ${model.getVersion} Build (${model.getBuildNumber})",
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

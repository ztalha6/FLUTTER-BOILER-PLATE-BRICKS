import 'package:app_essentials/app/data/config/app_configuration.dart';
import 'package:app_essentials/app/data/services/app_service.dart';
import 'package:app_essentials/app/data/services/token_manager.dart';
import 'package:get/get.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  Configuration configs = Configuration();
  final AppService _appService = AppService();
  Rxn<PackageInfo> packageInfo = Rxn<PackageInfo>();
  String get getVersion =>
      packageInfo.value == null ? "-" : packageInfo.value!.version;
  String get getBuildNumber =>
      packageInfo.value == null ? "-" : packageInfo.value!.buildNumber;

  @override
  Future<void> onInit() async {
    super.onInit();
    packageInfo.value = await PackageInfo.fromPlatform();
    // await Future.delayed(3.seconds);
    // await RestaurantRepository().setTheme();
    if (!await _appService.getFirstStart()) {
      await _appService.setFirstStart();
      Get.offAndToNamed(Routes.ONBOARDING);
      return;
    }
    if ((await TokenManager().getToken()).isNotEmpty) {
      Get.offAndToNamed(Routes.HOME);
      return;
    }

    Get.offAndToNamed(Routes.SIGN_IN);
  }
}

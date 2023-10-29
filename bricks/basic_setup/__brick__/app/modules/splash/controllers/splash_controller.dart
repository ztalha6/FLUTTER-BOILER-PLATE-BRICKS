import 'package:get/get.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/constants/configuration.dart';
import '../../../routes/app_pages.dart';
import '../../../data/services/app_service.dart';

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
    // if (!await _appService.getFirstStart()) {
    //   await _appService.setFirstStart();
    Get.offAndToNamed(Routes.ONBOARDING);
    //   return;
    // }
    // if ((await TokenManager().getToken()).isNotEmpty) {
    //   final User? user = await UserManager().getUser();
    //   if (user!.addressDetail == null || user.establishmentId == null) {
    //     Get.offAndToNamed(Routes.HOME);
    //     return;
    //   }
    //   Get.offAndToNamed(Routes.DRAWER);
    //   return;
    // }

    // Get.offAndToNamed(Routes.SIGN_IN);
  }
}

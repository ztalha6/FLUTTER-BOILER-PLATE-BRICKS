import 'package:get/get.dart';

import '../controllers/verify_otp_controller.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpController>(
      () => VerifyOtpController(),
    );
  }
}

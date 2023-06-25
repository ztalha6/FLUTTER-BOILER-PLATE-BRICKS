import 'package:get/get.dart';

import '../controllers/create_password_controller.dart';

class CreatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePasswordController>(
      () => CreatePasswordController(),
    );
  }
}

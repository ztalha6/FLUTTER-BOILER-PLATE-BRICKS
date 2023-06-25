import 'package:get/get.dart';

import '../controllers/post_sign_up_controller.dart';
import '../controllers/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}

class PostSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostSignUpController>(
      () => PostSignUpController(),
    );
  }
}

import 'package:get/get.dart';

import '../../../../data/constants/configuration.dart';

class OnboardingController extends GetxController {
  Configuration configs = Configuration();

  RxBool visible = false.obs;
}

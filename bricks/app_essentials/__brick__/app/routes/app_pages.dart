import 'package:get/get.dart';

import '../modules/auth/create_password/bindings/create_password_binding.dart';
import '../modules/auth/create_password/views/create_password_view.dart';
import '../modules/auth/forget_passsword/bindings/forget_passsword_binding.dart';
import '../modules/auth/forget_passsword/views/forget_passsword_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/auth/sign_in/bindings/sign_in_binding.dart';
import '../modules/auth/sign_in/views/sign_in_view.dart';
import '../modules/auth/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth/sign_up/views/post_sign_up_view.dart';
import '../modules/auth/sign_up/views/sign_up_view.dart';
import '../modules/auth/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/auth/verify_otp/views/verify_otp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.POST_SIGN_UP,
      page: () => const PostSignUpView(),
      binding: PostSignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSSWORD,
      page: () => const ForgetPassswordView(),
      binding: ForgetPassswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => VerifyOtpView(
        fromSignUp: Get.arguments[0],
        fromSignIn: Get.arguments[1],
        email: Get.arguments[2],
      ),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PASSWORD,
      page: () => const CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}

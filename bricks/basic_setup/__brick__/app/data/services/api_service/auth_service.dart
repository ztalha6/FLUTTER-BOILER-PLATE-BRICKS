import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../models/change_password/change_password_request_model.dart';
import '../../models/resend_otp/resend_otp_request_model.dart';
import '../../models/reset_password/reset_pass_request_model.dart';
import '../../models/sign_in/sign_in_request_model.dart';
import '../../models/sign_up/sign_in_request_model.dart';
import '../../models/verify_otp/verify_otp_request_model.dart';

class AuthService {
  Future<dynamic> signUpUser(SignUpRequest requestModel) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(passDomain: true);
    final Response response = await dioBuilderResponse.dio.post(
      signUpApiConstant,
      options: dioBuilderResponse.dioOptions,
      data: requestModel.toJson(),
    );
    return response;
  }

  Future<dynamic> resetPassword(ResetPasswordRequest requestModel) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(passDomain: true);
    final Response response = await dioBuilderResponse.dio.post(
      resetApiConstant,
      options: dioBuilderResponse.dioOptions,
      data: requestModel.toJson(),
    );
    return response;
  }

  Future<dynamic> signInUser(
    AccessRequest requestModel, {
    bool isSocial = false,
  }) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(passDomain: true);
    final Response response = await dioBuilderResponse.dio.post(
      isSocial ? socialSignInApiConstant : signInApiConstant,
      options: dioBuilderResponse.dioOptions,
      data: requestModel.toJson(),
    );
    return response;
  }

  Future<dynamic> guestSignIn() async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(passDomain: true);
    final Response response = await dioBuilderResponse.dio.post(
      registerGuestUser,
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> verifyOtp(OtpRequest requestModel) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(passDomain: true);
    final Response response = await dioBuilderResponse.dio.post(
      verifyOtpApiConstant,
      options: dioBuilderResponse.dioOptions,
      data: requestModel.toJson(),
    );
    return response;
  }

  Future<dynamic> sendOtp(ResendOtpRequest requestModel) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(passDomain: true);
    final Response response = await dioBuilderResponse.dio.post(
      resendOtpApiConstant,
      options: dioBuilderResponse.dioOptions,
      data: requestModel.toJson(),
    );
    return response;
  }

  Future<dynamic> changePassword(ChangePasswordRequest requestModel) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);

    final Response response = await dioBuilderResponse.dio.post(
      changePasswordApiConstant,
      options: dioBuilderResponse.dioOptions,
      data: requestModel.toJson(),
    );
    return response;
  }
}

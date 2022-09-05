import '../dio_service/dio_builder.dart';
import 'package:dio/dio.dart';

class AuthService {
  Future<dynamic> signInUser(YourRequestModel requestModel) async {
    DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: false);

    Response response = await dioBuilderResponse.dio.post(
      /* These are the constant that we have created in api_constants.dart, base url is embedded in the DioBuilder. */
      api_constants.signIpUser,
      options: dioBuilderResponse.dioOptions,
      data: requestModel.toJson(),
    );
    return response;
  }
}

import 'package:dio/dio.dart';

enum ResponseStatus {
  NULL_RESPONSE,
  NULL_ARGUMENT,
  SUCCESS,
  RESPONSE_ERROR,
  SESSION_EXPIRE
}

class ResponseModel<T> {
  T? response;
  String? error;
  ResponseStatus status;

  ResponseModel({this.error, required this.status, this.response});

  static Future<ResponseModel<T>> fromApiResponse<T extends BaseApiResponse>(
    Future<Response> Function() apiCall,
    T Function(Map<String, dynamic> body) parser,
  ) async {
    try {
      Response apiResponse = await apiCall();
      return handleResponse<T>(parser, apiResponse);
    } on DioError catch (e) {
      // Logger().e('Error on API request: $e');
      return ResponseModel(
        status: ResponseStatus.NULL_RESPONSE,
        response: null,
        error: (e.error.runtimeType.toString() == "HandshakeException" ||
                    e.error.runtimeType.toString() == "SocketException") &&
                Env.currentEnv != Envs.ProductionEnv
            ? e.error.toString()
            : 'Please check your internet connection.',
      );
    }
  }

  static ResponseModel<T> handleResponse<T extends BaseApiResponse>(
    T Function(Map<String, dynamic> body) parser,
    Response apiResponse,
  ) {
    if ((apiResponse.statusCode! < 300 && apiResponse.statusCode! >= 200) ||
        apiResponse.statusCode == 500) {
      // Logger().i("${apiResponse.requestOptions?.uri ?? 'cache'} response: ");
      // Logger().i(apiResponse.data);
      T response = parser(apiResponse.data);
      if (Utils().isNotNull(response.error)) {
        if (response.error!.errorCode == 'AUTH-0004') {
          // locator<NavigationService>().clearStackAndShow(signInView);
          // UiUtil.determineSessionExpired();
          return ResponseModel<T>(
            status: ResponseStatus.SESSION_EXPIRE,
            response: null,
            error: 'Session expire',
          );
        } else {
          return ResponseModel<T>(
            status: ResponseStatus.RESPONSE_ERROR,
            response: response,
            error: response.error!.errorMessage,
          );
        }
      } else {
        return ResponseModel<T>(
          status: ResponseStatus.SUCCESS,
          response: response,
          error: null,
        );
      }
    } else {
      return ResponseModel(
        status: ResponseStatus.NULL_RESPONSE,
        response: null,
        error: apiResponse.data['error']['error_message'],
      );
    }
  }
}

class BaseApiResponse {
  Error? error;
}

class Error {
  String? errorCode;
  String? errorMessage;

  Error({this.errorCode, this.errorMessage});

  Error.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['error_message'] = errorMessage;
    return data;
  }
}

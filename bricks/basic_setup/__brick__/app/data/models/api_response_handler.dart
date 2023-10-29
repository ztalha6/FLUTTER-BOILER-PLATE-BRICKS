import 'package:dio/dio.dart';
import 'response_model.dart';
import '../services/dio_service/api_interceptor.dart';

class ApiResponseHandler<T extends BaseApiResponse> {
  final T Function(Map<String, dynamic> body) parser;
  final Response apiResponse;

  ApiResponseHandler(this.parser, this.apiResponse);

  ResponseModel<T> handleResponse() {
    if (_isInvalidCredentialsError(apiResponse)) {
      return _buildErrorResponse(apiResponse.data);
    }

    if (_isUnauthorized(apiResponse)) {
      throw UnauthorizedException(apiResponse.requestOptions);
    }

    if (_hasErrors(apiResponse)) {
      return _buildErrorResponse(apiResponse.data);
    }

    if (_isSuccess(apiResponse)) {
      return _buildSuccessResponse(apiResponse.data);
    }

    return _buildNullResponse(
      apiResponse.data?['message'] as String? ?? "Something is wrong!",
    );
  }

  bool _isInvalidCredentialsError(Response apiResponse) {
    return apiResponse.headers.value("x-auth-error") == "InvalidCredentials";
  }

  bool _isUnauthorized(Response apiResponse) {
    return apiResponse.statusCode == 401;
  }

  bool _isSuccess(Response apiResponse) {
    return (apiResponse.statusCode! < 300 && apiResponse.statusCode! >= 200) ||
        apiResponse.statusCode == 500;
  }

  bool _hasErrors(Response apiResponse) {
    return _isSuccess(apiResponse) &&
        apiResponse.data != null &&
        !(parser(apiResponse.data)).status!;
  }

  ResponseModel<T> _buildErrorResponse(Map<String, dynamic> responseData) {
    final T response = parser(responseData);
    return ResponseModel<T>(
      status: ResponseStatus.responseError,
      error: response.message,
      response: response,
    );
  }

  ResponseModel<T> _buildSuccessResponse(Map<String, dynamic>? responseData) {
    final T? response = responseData == null ? null : parser(responseData);
    return ResponseModel<T>(
      status: ResponseStatus.success,
      response: response,
      error: response?.message,
    );
  }

  ResponseModel<T> _buildNullResponse(String errorMessage) {
    return ResponseModel(
      status: ResponseStatus.nullResponse,
      error: errorMessage,
    );
  }
}

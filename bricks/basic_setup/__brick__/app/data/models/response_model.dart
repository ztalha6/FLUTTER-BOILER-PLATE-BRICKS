import 'package:dio/dio.dart';

import 'api_response_handler.dart';

enum ResponseStatus {
  nullResponse,
  nullArgument,
  success,
  responseError,
  sessionExpire
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
      final Response apiResponse = await apiCall();
      return ApiResponseHandler<T>(parser, apiResponse).handleResponse();
    } on DioException {
      rethrow;
    }
  }
}

class BaseApiResponse {
  bool? status;
  String? message;

  BaseApiResponse({this.status, this.message});

  bool get hasError => !status! && message!.isNotEmpty;

  BaseApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool;
    message = json['message'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

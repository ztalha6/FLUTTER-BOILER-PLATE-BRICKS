import 'dart:developer';

import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final Dio dio;

  DioInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    log('[ URL: ${options.baseUrl}${options.path} ]');
    log('[ Headers: ${options.headers} ]');
    log('[ Request: ${options.data} ]');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    log('[ Response: ${response.data} ]');
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('[ Error ] $err');
    log('[ Error Response] ${err.response}');
    if (err.response != null) {
      switch (err.response?.statusCode) {
        case 400:
          throw BadRequestException(err.requestOptions);
        case 401:
          if (err.response?.headers.value("x-auth-error") ==
              "InvalidCredentials") {
            throw InvalidCredentialsException(err.requestOptions);
          }
          throw UnauthorizedException(err.requestOptions);
        case 403:
          throw UnauthorizedException(err.requestOptions);
        case 404:
          throw NotFoundException(err.requestOptions);
        case 409:
          throw ConflictException(err.requestOptions);
        case 500:
          throw InternalServerErrorException(err.requestOptions);
      }
    }
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
      case DioErrorType.badCertificate:
        throw BadCertificateException(err.requestOptions);
      case DioErrorType.badResponse:
        throw BadResponseException(err.requestOptions);
      case DioErrorType.connectionError:
        throw ConnectionErrorException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class BadCertificateException extends DioError {
  BadCertificateException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Bad certificate';
  }
}

class BadResponseException extends DioError {
  BadResponseException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Bad response';
  }
}

class ConnectionErrorException extends DioError {
  ConnectionErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection error';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class InvalidCredentialsException extends DioError {
  InvalidCredentialsException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid credentials';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

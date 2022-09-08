# Basic Setup

A brick to create the basic structure for the API Integration and Beta setup foran application. This brick will create  a massive structure on your directory and genrates some ready to use code.

All you have to do is to call the mehtods in controllers and do business logic stuff.

## Features
This brick will create following modules for you:
- Constants
    - api constants file
    - assets constants file
- Environment
    - env model file
    - all envrionments file
- Model
    - Repository model file
    - API response model file
- Repository
    - Sample auth repository file
- Services
    - api service 
        - sample auth service file
    - Dio service
        - api interceptor
        - dio builder
    - exception handler
    - snackbar manager
    - api token manager
- Utils
    - image utils
    - general utils
- widgets
    base widget (with predefined ThemeData)

## How to use 🚀

```
mason make basic_setup
```

## Variables ✨

| Variable         | Description                      | Default | Type      |
| ---------------- | -------------------------------- | ------- | --------- |
| `using_snakbar`  | If you are using snackbar        | true    | `boolean` |
|                  | from this mason_cli              |         |           |
| `baseUrl`        | The base URL you want to         |   -     | `string`  |
|                  | keep for your API                |         |           |
|                  | (http://yourWebsite.com/api/)    |         |           |

## Outputs 📦

```
constants
├── api_constants.dart
├── assets_constants.dart

env
├── env.dart 
├── envs.dart 

models
├── repository_response_model.dart
├── response_model.dart

repositories
├── auth_repository.dart

services
├── api_service
    ├── auth_service.dart
├── dio_service
    ├── api_interceptor.dart
    ├── dio_builder.dart
├── exception_handler.dart
├── snackbar_manager.dart
├── token_manager.dart

utils
├── image_utils.dart
├── utils.dart

widgets
├── base_widget.dart

```

```dart
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioBuilderResponse {
  Dio dio;
  Options dioOptions;

  DioBuilderResponse({required this.dio, required this.dioOptions});
}

class DioBuilder {
  Options _getCachedDioOptions() {
    return buildCacheOptions(
      const Duration(days: 30),
      forceRefresh: true,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 501;
        },
      ),
    );
  }

  Future<DioBuilderResponse> buildCachedDio({
    bool hasAuth = true,
    bool shouldQueue = false,
  }) async {
    DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
    Options dioOptions = _getCachedDioOptions();
    String token = await TokenManager().getToken();
    Dio dio = Dio(BaseOptions(
        baseUrl: Env.currentEnv.baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        headers: hasAuth
            ? {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }
            : {
                'Content-Type': 'application/json',
              }));
    dio.interceptors.add(DioInterceptor(dio));
    dio.interceptors.add(dioCacheManager.interceptor);
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Future<DioBuilderResponse> buildNonCachedDio({
    bool hasAuth = true,
    bool shouldQueue = false,
  }) async {
    Options dioOptions = _getDioOptions();
    String token = await TokenManager().getToken();
    Dio dio = Dio(BaseOptions(
        baseUrl: Env.currentEnv.baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        headers: hasAuth
            ? {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }
            : {
                'Content-Type': 'application/json',
              }));
    dio.interceptors.add(DioInterceptor(dio));
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Options _getDioOptions() {
    return Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 501;
      },
    );
  }
}

```
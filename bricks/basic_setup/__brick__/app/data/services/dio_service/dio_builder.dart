import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../env/env.dart';
import '../token_manager.dart';
import 'api_interceptor.dart';

class DioBuilderResponse {
  Dio dio;
  Options dioOptions;

  DioBuilderResponse({required this.dio, required this.dioOptions});
}

final CacheOptions cacheOptions = CacheOptions(
  // A default store is required for interceptor.
  store: MemCacheStore(),
  priority: CachePriority.high,
  // Returns a cached response on error but for statuses 401 & 403.
  // Also allows to return a cached response on network errors (e.g. offline usage).
  // Defaults to [null].
  // hitCacheOnErrorExcept: [401, 403],
  // Overrides any HTTP directive to delete entry past this duration.
  // Useful only when origin server has no cache config or custom behaviour is desired.
  // Defaults to [null].
  maxStale: const Duration(days: 30),
  // Default. Allows to cache POST requests.
  // Overriding [keyBuilder] is strongly recommended when [true].
  allowPostMethod: true,
);

class DioBuilder {
  Future<DioBuilderResponse> buildCachedDio({
    bool hasAuth = true,
    bool shouldQueue = false,
    bool passDomain = false,
    bool useAccessToken = false,
    String accessToken = '',
  }) async {
    if (useAccessToken) {
      assert(accessToken.isNotEmpty);
    }

    final DioCacheInterceptor dioCacheManager =
        DioCacheInterceptor(options: cacheOptions);
    final Options dioOptions = cacheOptions.toOptions();
    final String token = await TokenManager().getToken();
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Env.currentEnv.baseUrl,
        connectTimeout: const Duration(milliseconds: 15000),
        receiveTimeout: const Duration(milliseconds: 15000),
        headers: {
          if (hasAuth) 'Authorization': token,
          'Content-Type': 'application/json',
          if (useAccessToken) 'AccessToken': accessToken,
        },
      ),
    );
    dio.interceptors.add(DioInterceptor(dio));
    dio.interceptors.add(dioCacheManager);
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Future<DioBuilderResponse> buildNonCachedDio({
    bool hasAuth = false,
    bool shouldQueue = false,
    bool useAccessToken = false,
    bool isFromData = false,
    bool useXAccessToken = false,
    String xAccessToken = '',
    String accessToken = '',
    bool sendRequestWithBaseUrl = true,
  }) async {
    if (useXAccessToken) {
      assert(xAccessToken.isNotEmpty);
    }
    if (useAccessToken) {
      assert(accessToken.isNotEmpty);
    }

    final Options dioOptions = _getDioOptions();
    final String token = await TokenManager().getToken();
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: sendRequestWithBaseUrl ? Env.currentEnv.baseUrl : '',
        connectTimeout: const Duration(milliseconds: 15000),
        receiveTimeout: const Duration(milliseconds: 15000),
        headers: {
          if (hasAuth) 'Authorization': token,
          'Content-Type':
              isFromData ? 'multipart/form-data' : 'application/json',
          if (useAccessToken) 'AccessToken': accessToken,
          if (useXAccessToken) 'x-access-token': xAccessToken,
        },
      ),
    );
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

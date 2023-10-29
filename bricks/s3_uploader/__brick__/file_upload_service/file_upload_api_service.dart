import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

import '../dio_service/dio_builder.dart';
import 'model/request/upload_file_s3_request_model.dart';

class FileUploadService {
  final String backendUrlforS3Credentials;
  final String xAccessToken;

  FileUploadService({
    required this.backendUrlforS3Credentials,
    required this.xAccessToken,
  });

  Future<dynamic> getSignedUrlsFromBackend({required String filePath}) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(
      useXAccessToken: true,
      hasAuth: true,
      sendRequestWithBaseUrl: false,
      xAccessToken: xAccessToken,
    );
    final Response response = await dioBuilderResponse.dio.post(
      backendUrlforS3Credentials,
      options: dioBuilderResponse.dioOptions,
      data: {
        'contentType': lookupMimeType(filePath),
      },
    );
    return response;
  }

  Future<dynamic> uploadImageToS3Bucket({
    required S3UploadFileRequest requestModel,
    required Function(int, int) onSendProgress,
  }) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(
      useXAccessToken: true,
      sendRequestWithBaseUrl: false,
      xAccessToken: xAccessToken,
      isFromData: true,
    );
    final Response response = await dioBuilderResponse.dio.post(
      requestModel.url,
      options: dioBuilderResponse.dioOptions,
      data: await requestModel.toFormData(),
      onSendProgress: onSendProgress,
    );
    return response;
  }
}

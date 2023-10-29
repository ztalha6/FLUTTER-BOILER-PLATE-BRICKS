import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/configuration.dart';
import '../../models/repository_response_model.dart';
import '../../models/response_model.dart';
import '../exception_handler.dart';
import 'file_upload_api_service.dart';
import 'model/response/pre_signed_model_response.dart';
import '../snackbar_manager.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'model/request/upload_file_s3_request_model.dart';

class FileUploadRepository {
  FileUploadService imageUploadService;
  FileUploadRepository({
    required this.imageUploadService,
  });

  Future<RepositoryResponse<String>> getSignedUrlsFromBackend({
    required String filePath,
  }) async {
    final ProgressDialog pd = ProgressDialog(context: Get.context);
    pd.show(
      progressType: ProgressType.valuable,
      valuePosition: ValuePosition.center,
      msg: 'Uploading File',
      progressValueColor: Configuration().primaryColor,
      barrierColor: Colors.black45,
      progressBgColor: Colors.black87,
      msgFontSize: 14,
      valueFontSize: 12,
    );
    try {
      final ResponseModel<PresignedUrlModelResponse> responseModel =
          await ResponseModel.fromApiResponse<PresignedUrlModelResponse>(
        () async => await imageUploadService.getSignedUrlsFromBackend(
          filePath: filePath,
        ),
        (body) => PresignedUrlModelResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        final PresignedUrlModelResponseData model =
            responseModel.response!.data!;

        final fileName = filePath.split('/').last;

        final RepositoryResponse<String> s3Response =
            await _uploadImageToS3Bucket(
          model: model,
          fileName: fileName,
          filePath: filePath,
          onSendProgress: (send, total) {
            final int progress = ((send / total) * 100).toInt();
            pd.update(value: progress);
          },
        );
        pd.close();
        return s3Response;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
        pd.close();
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
      pd.close();
      return RepositoryResponse(isSuccess: false);
    }
    pd.close();
    return RepositoryResponse(isSuccess: false);
  }

  Future<RepositoryResponse<String>> _uploadImageToS3Bucket({
    required PresignedUrlModelResponseData model,
    required String filePath,
    required String fileName,
    required Function(int, int) onSendProgress,
  }) async {
    try {
      final ResponseModel<BaseApiResponse> responseModel =
          await ResponseModel.fromApiResponse<BaseApiResponse>(
        () async => await imageUploadService.uploadImageToS3Bucket(
          onSendProgress: onSendProgress,
          requestModel: S3UploadFileRequest(
            acl: model.result!.fields!.aCL!,
            contentType: model.result!.fields!.contentType!,
            bucket: model.result!.fields!.bucket!,
            xAmzAlgorithm: model.result!.fields!.xAmzAlgorithm!,
            xAmzCredential: model.result!.fields!.xAmzCredential!,
            xAmzDate: model.result!.fields!.xAmzDate!,
            key: model.result!.fields!.key!,
            policy: model.result!.fields!.policy!,
            xAmzSignature: model.result!.fields!.xAmzSignature!,
            fileName: fileName,
            filePath: filePath,
            url: model.result!.url!.replaceAll(" ", ""),
          ),
        ),
        (body) => BaseApiResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return RepositoryResponse(isSuccess: true, data: model.url);
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
      return RepositoryResponse(isSuccess: false);
    }
    return RepositoryResponse(isSuccess: false);
  }
}

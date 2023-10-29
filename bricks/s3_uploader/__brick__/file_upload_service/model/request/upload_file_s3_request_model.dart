import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class S3UploadFileRequest extends Equatable {
  const S3UploadFileRequest({
    required this.acl,
    required this.contentType,
    required this.bucket,
    required this.xAmzAlgorithm,
    required this.xAmzCredential,
    required this.xAmzDate,
    required this.key,
    required this.policy,
    required this.xAmzSignature,
    required this.filePath,
    required this.fileName,
    required this.url,
  });

  final String acl;
  final String contentType;
  final String bucket;
  final String xAmzAlgorithm;
  final String xAmzCredential;
  final String xAmzDate;
  final String key;
  final String policy;
  final String xAmzSignature;
  final String filePath;
  final String fileName;
  final String url;

  factory S3UploadFileRequest.fromJson(Map<String, dynamic> json) {
    return S3UploadFileRequest(
      acl: json["ACL"] ?? "",
      contentType: json["Content-Type"] ?? "",
      bucket: json["bucket"] ?? "",
      xAmzAlgorithm: json["X-Amz-Algorithm"] ?? "",
      xAmzCredential: json["X-Amz-Credential"] ?? "",
      xAmzDate: json["X-Amz-Date"] ?? "",
      key: json["Key"] ?? "",
      policy: json["Policy"] ?? "",
      xAmzSignature: json["X-Amz-Signature"] ?? "",
      filePath: json["imgae_file"] ?? "",
      fileName: json["file_name"] ?? "",
      url: json["url"] ?? "",
    );
  }

  Future<Map<String, dynamic>> toJson() async => {
        "ACL": acl,
        "Content-Type": contentType,
        "bucket": bucket,
        "X-Amz-Algorithm": xAmzAlgorithm,
        "X-Amz-Credential": xAmzCredential,
        "X-Amz-Date": xAmzDate,
        "Key": key,
        "Policy": policy,
        "X-Amz-Signature": xAmzSignature,
        "file": await MultipartFile.fromFile(filePath, filename: fileName)
      };

  Future<FormData> toFormData() async => FormData.fromMap(await toJson());

  @override
  String toString() {
    return "$acl, $contentType, $bucket, $xAmzAlgorithm, $xAmzCredential, $xAmzDate, $key, $policy, $xAmzSignature,$url ";
  }

  @override
  List<Object?> get props => [
        acl,
        contentType,
        bucket,
        xAmzAlgorithm,
        xAmzCredential,
        xAmzDate,
        key,
        policy,
        xAmzSignature,
        url
      ];
}

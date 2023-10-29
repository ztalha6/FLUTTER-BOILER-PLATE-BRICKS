import '../../../../models/response_model.dart';

class PresignedUrlModelResponse extends BaseApiResponse {
  PresignedUrlModelResponse({
    required this.data,
  });

  PresignedUrlModelResponseData? data;

  PresignedUrlModelResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? false;
    message = json["message"] ?? "";
    data = json["data"] == null
        ? null
        : PresignedUrlModelResponseData.fromJson(json["data"]);
  }

  @override
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$status, $message, $data, ";
  }

  List<Object?> get props => [
        status,
        message,
        data,
      ];
}

class PresignedUrlModelResponseData {
  Result? result;
  String? url;

  PresignedUrlModelResponseData({this.result, this.url});

  PresignedUrlModelResponseData.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['url'] = url;
    return data;
  }
}

class Result {
  String? url;
  Fields? fields;

  Result({this.url, this.fields});

  Result.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    if (fields != null) {
      data['fields'] = fields!.toJson();
    }
    return data;
  }
}

class Fields {
  String? key;
  String? contentType;
  String? aCL;
  String? bucket;
  String? xAmzAlgorithm;
  String? xAmzCredential;
  String? xAmzDate;
  String? policy;
  String? xAmzSignature;

  Fields({
    this.key,
    this.contentType,
    this.aCL,
    this.bucket,
    this.xAmzAlgorithm,
    this.xAmzCredential,
    this.xAmzDate,
    this.policy,
    this.xAmzSignature,
  });

  Fields.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    contentType = json['Content-Type'];
    aCL = json['ACL'];
    bucket = json['bucket'];
    xAmzAlgorithm = json['X-Amz-Algorithm'];
    xAmzCredential = json['X-Amz-Credential'];
    xAmzDate = json['X-Amz-Date'];
    policy = json['Policy'];
    xAmzSignature = json['X-Amz-Signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Key'] = key;
    data['Content-Type'] = contentType;
    data['ACL'] = aCL;
    data['bucket'] = bucket;
    data['X-Amz-Algorithm'] = xAmzAlgorithm;
    data['X-Amz-Credential'] = xAmzCredential;
    data['X-Amz-Date'] = xAmzDate;
    data['Policy'] = policy;
    data['X-Amz-Signature'] = xAmzSignature;
    return data;
  }
}

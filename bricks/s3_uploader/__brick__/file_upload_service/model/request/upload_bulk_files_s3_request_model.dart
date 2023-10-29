import 'package:equatable/equatable.dart' show Equatable;

class S3BulkFileUploadRequest extends Equatable {
  const S3BulkFileUploadRequest({
    required this.files,
  });

  final List<FileItem> files;

  factory S3BulkFileUploadRequest.fromJson(Map<String, dynamic> json) {
    return S3BulkFileUploadRequest(
      files: json["items"] == null
          ? []
          : List<FileItem>.from(
              json["items"]!.map((x) => FileItem.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "items": files.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$files, ";
  }

  @override
  List<Object?> get props => [
        files,
      ];
}

class FileItem extends Equatable {
  const FileItem({
    required this.name,
    required this.contentType,
  });

  final String name;
  final String contentType;

  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      name: json["name"] ?? "",
      contentType: json["contentType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "contentType": contentType,
      };

  @override
  String toString() {
    return "$name, $contentType, ";
  }

  @override
  List<Object?> get props => [
        name,
        contentType,
      ];
}

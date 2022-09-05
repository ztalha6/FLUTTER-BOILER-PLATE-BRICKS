class RepositoryResponse<T> {
  final bool isSuccess;
  final T? data;
  final String? message;

  RepositoryResponse({
    required this.isSuccess,
    this.data,
    this.message,
  });
}

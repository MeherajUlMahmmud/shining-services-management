class ApiResponse<T> {
  final T? data;
  final int status;
  final String? error;

  ApiResponse({
    required this.status,
    this.data,
    this.error,
  });

  // Helper to quickly create an error response
  factory ApiResponse.error(int status, String error) {
    return ApiResponse<T>(status: status, error: error);
  }
}

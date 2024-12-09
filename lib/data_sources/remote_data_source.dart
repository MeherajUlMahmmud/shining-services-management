import 'package:dio/dio.dart';
import 'package:shining_services_management/utils/app_logger.dart';
import 'package:shining_services_management/utils/constants.dart';

class APIService {
  final Dio _dio;

  APIService()
      : _dio = Dio(BaseOptions(
    baseUrl: ApiUrl.kBaseUrl,
    headers: {'Content-Type': 'application/json'},
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        AppLogger().info("Starting request: [${options.method}] ${options.uri}");
        AppLogger().debug("Request Headers: ${options.headers}");
        AppLogger().debug("Request Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        AppLogger().info("Received response: [${response.statusCode}] for ${response.requestOptions.uri}");
        AppLogger().debug("Response Data: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        AppLogger().error(
          "Request error: [${e.response?.statusCode ?? 'No Status Code'}] ${e.message}",
          error: e,
          stackTrace: e.stackTrace,
        );
        return handler.next(e);
      },
    ));
  }

  Future<Map<String, dynamic>> _handleRequest(
      Future<Response> Function() request) async {
    AppLogger().info("Initiating request...");

    try {
      final response = await request();
      AppLogger().info("Request completed successfully with status ${response.statusCode}.");
      return {
        'data': response.data,
        'status': response.statusCode,
      };
    } on DioException catch (e) {
      AppLogger().error("Request failed with DioException: ${e.message}", error: e);
      return {
        'error': e.message,
        'status': e.response?.statusCode ?? 500,
      };
    }
  }

  Future<Map<String, dynamic>> sendUnauthenticatedPostRequest(
      Map<String, dynamic> data, String url) async {
    AppLogger().info("Sending unauthenticated POST request to $url with data: $data");
    final response = await _handleRequest(() => _dio.post(url, data: data));
    AppLogger().info("Unauthenticated POST request to $url completed.");
    return response;
  }

  Future<Map<String, dynamic>> sendPostRequest(
      String accessToken, Map<String, dynamic> data, String url) async {
    AppLogger().info("Sending authenticated POST request to $url with token: $accessToken and data: $data");
    final response = await _handleRequest(() => _dio.post(
      url,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    ));
    AppLogger().info("Authenticated POST request to $url completed.");
    return response;
  }

  Future<Map<String, dynamic>> sendUnauthenticatedGetRequest(String url) async {
    AppLogger().info("Sending unauthenticated GET request to $url");
    final response = await _handleRequest(() => _dio.get(url));
    AppLogger().info("Unauthenticated GET request to $url completed.");
    return response;
  }

  Future<Map<String, dynamic>> sendGetRequest(
      String accessToken, String url) async {
    AppLogger().info("Sending authenticated GET request to $url with token: $accessToken");
    final response = await _handleRequest(() => _dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    ));
    AppLogger().info("Authenticated GET request to $url completed.");
    return response;
  }

  Future<Map<String, dynamic>> sendPatchRequest(
      String accessToken, Map<String, dynamic> data, String url,
      {bool isMultipart = false}) async {
    AppLogger().info("Sending PATCH request to $url with token: $accessToken and data: $data. IsMultipart: $isMultipart");

    final options = Options(
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    final requestFunction = isMultipart
        ? () => _dio.patch(url, data: FormData.fromMap(data), options: options)
        : () => _dio.patch(url, data: data, options: options);

    final response = await _handleRequest(requestFunction);
    AppLogger().info("PATCH request to $url completed.");
    return response;
  }

  Future<Map<String, dynamic>> sendDeleteRequest(
      String accessToken, String url) async {
    AppLogger().info("Sending DELETE request to $url with token: $accessToken");
    final response = await _handleRequest(() => _dio.delete(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    ));
    AppLogger().info("DELETE request to $url completed.");
    return response;
  }
}

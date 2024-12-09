

import 'package:shining_services_management/data_sources/remote_data_source.dart';
import 'package:shining_services_management/models/api/api_response.dart';
import 'package:shining_services_management/models/api/auth_api_request.dart';
import 'package:shining_services_management/utils/app_logger.dart';
import 'package:shining_services_management/utils/constants.dart';

import 'i_remote_auth_repository.dart';

class RemoteAuthRepository implements IRemoteAuthRepository {
  final APIService _apiService;

  RemoteAuthRepository() : _apiService = APIService();

  @override
  Future<ApiResponse<Map<String, dynamic>>> registerUser(
      RegisterRequest request) async {
    AppLogger()
        .info("Sending register user request with data: ${request.toJson()}");
    try {
      final response = await _apiService.sendUnauthenticatedPostRequest(
        request.toJson(),
        ApiUrl.kRegisterUrl,
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("Register user request successful.");
        return ApiResponse(
          status: response['status'],
          data: response['data'],
        );
      } else {
        AppLogger().warn(
            "Register user request failed with status: ${response['status']}");
        return ApiResponse.error(
          response['status'],
          response['data']['detail'] ?? 'An error occurred',
        );
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during register user request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> loginUser(
      LoginRequest request) async {
    AppLogger()
        .info("Sending login user request with data: ${request.toJson()}");
    try {
      final response = await _apiService.sendUnauthenticatedPostRequest(
        request.toJson(),
        ApiUrl.kLoginUrl,
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("Login request successful.");
        return ApiResponse(
          status: response['status'],
          data: response['data'],
        );
      } else {
        AppLogger()
            .warn("Login request failed with status: ${response['status']}");
        return ApiResponse.error(
          response['status'],
          response['data']['detail'] ?? 'An error occurred',
        );
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during login request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> refreshToken(
      RefreshTokenRequest request) async {
    AppLogger()
        .info("Sending refresh token request with data: ${request.toJson()}");
    try {
      final response = await _apiService.sendUnauthenticatedPostRequest(
        request.toJson(),
        ApiUrl.kRefreshTokenUrl,
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("Refresh token request successful.");
        return ApiResponse(
          status: response['status'],
          data: response['data'],
        );
      } else {
        AppLogger().warn(
            "Refresh token request failed with status: ${response['status']}");
        return ApiResponse.error(
          response['status'],
          response['data']['detail'] ?? 'An error occurred',
        );
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during refresh token request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }
}

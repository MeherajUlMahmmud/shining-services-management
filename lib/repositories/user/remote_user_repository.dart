

import 'package:shining_services_management/data_sources/remote_data_source.dart';
import 'package:shining_services_management/models/api/api_response.dart';
import 'package:shining_services_management/utils/app_logger.dart';
import 'package:shining_services_management/utils/constants.dart';
import 'package:shining_services_management/utils/helper.dart';

import 'i_remote_user_repository.dart';

class RemoteUserRepository implements IRemoteUserRepository {
  final APIService _apiService;

  RemoteUserRepository() : _apiService = APIService();

  Future<ApiResponse<List<dynamic>>> fetchUserList(
      String accessToken, Map<String, dynamic> params) async {
    AppLogger().info(
        "Starting fetchUserList with accessToken and parameters: $params");

    try {
      final queryString = Helper().mapToQueryString(params);
      final response = await _apiService.sendGetRequest(
        accessToken,
        '${ApiUrl.kUserUrl}/list/?$queryString',
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("fetchUserList request successful.");
        return ApiResponse(status: response['status'], data: response['data']);
      } else {
        AppLogger().warn(
            "fetchUserList request failed with status: ${response['status']}");
        return ApiResponse.error(response['status'],
            response['data']['detail'] ?? 'An error occurred');
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during fetchUserList request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> fetchUserDetails(
      String accessToken, int userId) async {
    AppLogger().info("Starting fetchUserDetails for userId: $userId");

    try {
      final response = await _apiService.sendGetRequest(
        accessToken,
        '${ApiUrl.kUserUrl}/$userId/',
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("fetchUserDetails request successful.");
        return ApiResponse(status: response['status'], data: response['data']);
      } else {
        AppLogger().warn(
            "fetchUserDetails request failed with status: ${response['status']}");
        return ApiResponse.error(response['status'],
            response['data']['detail'] ?? 'An error occurred');
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during fetchUserDetails request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> fetchUserProfile(
      String accessToken) async {
    AppLogger().info("Starting fetchUserProfile");

    try {
      final response = await _apiService.sendGetRequest(
        accessToken,
        '${ApiUrl.kUserUrl}/profile/',
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("fetchUserProfile request successful.");
        return ApiResponse(status: response['status'], data: response['data']);
      } else {
        AppLogger().warn(
            "fetchUserProfile request failed with status: ${response['status']}");
        return ApiResponse.error(response['status'],
            response['data']['detail'] ?? 'An error occurred');
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during fetchUserProfile request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }

  Future<ApiResponse<void>> updateUser(
      String accessToken, int userId, Map<String, dynamic> updateData) async {
    AppLogger()
        .info("Starting updateUser for userId: $userId with data: $updateData");

    try {
      final response = await _apiService.sendPatchRequest(
        accessToken,
        updateData,
        '${ApiUrl.kUserUrl}/$userId/',
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("updateUser request successful.");
        return ApiResponse(status: response['status'], data: null);
      } else {
        AppLogger().warn(
            "updateUser request failed with status: ${response['status']}");
        return ApiResponse.error(response['status'],
            response['data']['detail'] ?? 'An error occurred');
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during updateUser request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }

  Future<ApiResponse<void>> updateEmail(
      String accessToken, Map<String, dynamic> updateData) async {
    AppLogger().info("Starting updateEmail with data: $updateData");

    try {
      final response = await _apiService.sendPatchRequest(
        accessToken,
        updateData,
        '${ApiUrl.kUserUrl}/update-email/',
      );

      if (response['status'] == HTTPStatus.httpOkCode) {
        AppLogger().info("updateEmail request successful.");
        return ApiResponse(status: response['status'], data: null);
      } else {
        AppLogger().warn(
            "updateEmail request failed with status: ${response['status']}");
        return ApiResponse.error(response['status'],
            response['data']['detail'] ?? 'An error occurred');
      }
    } catch (e, stackTrace) {
      AppLogger().error("Error during updateEmail request",
          error: e, stackTrace: stackTrace);
      return ApiResponse.error(500, e.toString());
    }
  }

  @override
  Future<ApiResponse<void>> updatePassword(
      String accessToken, Map<String, dynamic> updateData) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<void>> updatePhoneNumber(
      String accessToken, Map<String, dynamic> updateData) {
    // TODO: implement updatePhoneNumber
    throw UnimplementedError();
  }

// Add similar methods for updating phone number and password
}

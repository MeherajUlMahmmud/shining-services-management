
import 'package:shining_services_management/models/api/api_response.dart';

abstract class IRemoteUserRepository {
  Future<ApiResponse<List<dynamic>>> fetchUserList(String accessToken, Map<String, dynamic> params);

  Future<ApiResponse<Map<String, dynamic>>> fetchUserDetails(String accessToken, int userId);

  Future<ApiResponse<Map<String, dynamic>>> fetchUserProfile(String accessToken);

  Future<ApiResponse<void>> updateUser(String accessToken, int userId, Map<String, dynamic> updateData);

  Future<ApiResponse<void>> updateEmail(String accessToken, Map<String, dynamic> updateData);

  Future<ApiResponse<void>> updatePhoneNumber(String accessToken, Map<String, dynamic> updateData);

  Future<ApiResponse<void>> updatePassword(String accessToken, Map<String, dynamic> updateData);
}

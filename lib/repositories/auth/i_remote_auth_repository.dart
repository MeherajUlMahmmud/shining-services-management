import 'package:shining_services_management/models/api/api_response.dart';
import 'package:shining_services_management/models/api/auth_api_request.dart';

abstract class IRemoteAuthRepository {
  Future<ApiResponse<Map<String, dynamic>>> registerUser(
      RegisterRequest request);

  Future<ApiResponse<Map<String, dynamic>>> loginUser(LoginRequest request);

  Future<ApiResponse<Map<String, dynamic>>> refreshToken(
      RefreshTokenRequest request);
}

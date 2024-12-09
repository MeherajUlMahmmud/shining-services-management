import 'package:shining_services_management/models/auth/auth_data.dart';

abstract class ILocalAuthRepository {
  // Save the entire AuthData object
  Future<void> saveAuthData(AuthData authData);

  // Retrieve the entire AuthData object
  Future<AuthData?> getAuthData();

  // Save the access token (updates the existing AuthData object)
  Future<void> saveAccessToken(String accessToken);

  // Retrieve the access token from AuthData
  Future<String?> getAccessToken();

  // Save the refresh token (updates the existing AuthData object)
  Future<void> saveRefreshToken(String refreshToken);

  // Retrieve the refresh token from AuthData
  Future<String?> getRefreshToken();

  // Clear all stored authentication data (e.g., on logout)
  Future<void> clearAuthData();
}

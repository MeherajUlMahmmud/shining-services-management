import 'package:hive/hive.dart';
import 'package:shining_services_management/data_sources/local_data_source.dart';
import 'package:shining_services_management/models/auth/auth_data.dart';

import 'i_local_auth_repository.dart';

class LocalAuthRepository implements ILocalAuthRepository {
  final HiveStorageService<AuthData> _authStorage;

  LocalAuthRepository(Box<AuthData> authBox)
      : _authStorage = HiveStorageService<AuthData>.fromBox(authBox);

  // Save the auth data (both access and refresh tokens) locally
  @override
  Future<void> saveAuthData(AuthData authData) async {
    await _authStorage.saveItem('authData', authData);
  }

  // Retrieve the auth data from local storage
  @override
  Future<AuthData?> getAuthData() async {
    return _authStorage.loadItem('authData');
  }

  // Save the access token locally (updates the existing AuthData)
  @override
  Future<void> saveAccessToken(String accessToken) async {
    final currentAuthData = await getAuthData() ??
        AuthData(accessToken: accessToken, refreshToken: '');
    final updatedAuthData = currentAuthData.copyWith(accessToken: accessToken);
    await saveAuthData(updatedAuthData);
  }

  // Retrieve the access token from local storage
  @override
  Future<String?> getAccessToken() async {
    final authData = await getAuthData();
    return authData?.accessToken;
  }

  // Save the refresh token locally (updates the existing AuthData)
  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    final currentAuthData = await getAuthData() ??
        AuthData(accessToken: '', refreshToken: refreshToken);
    final updatedAuthData =
        currentAuthData.copyWith(refreshToken: refreshToken);
    await saveAuthData(updatedAuthData);
  }

  // Retrieve the refresh token from local storage
  @override
  Future<String?> getRefreshToken() async {
    final authData = await getAuthData();
    return authData?.refreshToken;
  }

  // Clear all authentication data (e.g., on logout)
  @override
  Future<void> clearAuthData() async {
    await _authStorage.clearAllItems();
  }
}

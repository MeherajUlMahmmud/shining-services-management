import 'package:hive/hive.dart';

part 'auth_data.g.dart'; // This part directive is for Hive code generation

@HiveType(typeId: 2) // Unique typeId for this class
class AuthData {
  @HiveField(0)
  final String accessToken; // Access token for authentication

  @HiveField(1)
  final String refreshToken; // Refresh token for re-authentication

  AuthData({
    required this.accessToken,
    required this.refreshToken,
  });

  // Optional: Convenience method to update tokens or expiry date
  AuthData copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthData(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

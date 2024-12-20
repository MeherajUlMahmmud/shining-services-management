class RegisterRequest {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password1;
  final String password2;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password1,
    required this.password2,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        'password1': password1,
        'password2': password2,
      };
}

class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
        'refresh': refreshToken,
      };
}

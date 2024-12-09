import 'package:shining_services_management/models/user/user.dart';

class LoginResponse {
  final String detail;
  final User user;
  final Tokens tokens;

  LoginResponse({
    required this.detail,
    required this.user,
    required this.tokens,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      detail: json['detail'],
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }
}

// class User {
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String authProvider;
//   final bool isVerified;
//   final bool isStaff;
//   final bool isSuperuser;
//   final int id;
//   final String profilePicture;
//
//   User({
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.authProvider,
//     required this.isVerified,
//     required this.isStaff,
//     required this.isSuperuser,
//     required this.id,
//     required this.profilePicture,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       email: json['email'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       authProvider: json['auth_provider'],
//       isVerified: json['is_verified'],
//       isStaff: json['is_staff'],
//       isSuperuser: json['is_superuser'],
//       id: json['id'],
//       profilePicture: json['profile_picture'],
//     );
//   }
// }

class Tokens {
  final String access;
  final String refresh;

  Tokens({
    required this.access,
    required this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      access: json['access'],
      refresh: json['refresh'],
    );
  }
}

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 3) // Assign a unique typeId for User
class User {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String authProvider;

  @HiveField(4)
  final bool isVerified;

  @HiveField(5)
  final bool isStaff;

  @HiveField(6)
  final bool isSuperuser;

  @HiveField(7)
  final int id;

  @HiveField(8)
  final String profilePicture;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.authProvider,
    required this.isVerified,
    required this.isStaff,
    required this.isSuperuser,
    required this.id,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      authProvider: json['auth_provider'],
      isVerified: json['is_verified'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
      id: json['id'],
      profilePicture: json['profile_picture'],
    );
  }
}

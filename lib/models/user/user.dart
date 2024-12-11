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
  final bool isVerified;

  @HiveField(4)
  final bool isStaff;

  @HiveField(5)
  final bool isAdmin;

  @HiveField(6)
  final String username;

  @HiveField(7)
  final int id;

  @HiveField(8)
  final bool isCrewMember;

  User({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    required this.isStaff,
    required this.isAdmin,
    required this.id,
    required this.isCrewMember,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      isCrewMember: json['is_crew_member'],
      isVerified: json['is_verified'],
      isStaff: json['is_staff'],
      isAdmin: json['is_admin'],
      id: json['id'],
    );
  }
}

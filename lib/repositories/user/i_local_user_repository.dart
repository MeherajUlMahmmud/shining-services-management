import 'package:shining_services_management/models/user/user.dart';

abstract class ILocalUserRepository {
  Future<void> saveUser(User user);

  Future<User?> getUser();

  Future<void> updateUser(User user);

  Future<void> clearUser();
}

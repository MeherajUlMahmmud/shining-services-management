import 'package:hive/hive.dart';
import 'package:shining_services_management/data_sources/local_data_source.dart';
import 'package:shining_services_management/models/user/user.dart';

import 'i_local_user_repository.dart';

class LocalUserRepository implements ILocalUserRepository {
  final HiveStorageService<User> _userStorage;

  // Accept the box as a dependency
  LocalUserRepository(Box<User> userBox)
      : _userStorage = HiveStorageService<User>.fromBox(userBox);

  @override
  Future<void> saveUser(User user) async {
    await _userStorage.saveItem('user', user);
  }

  @override
  Future<User?> getUser() async {
    return _userStorage.loadItem('user');
  }

  @override
  Future<void> updateUser(User user) async {
    await saveUser(user); // Simply overwrite the existing user
  }

  @override
  Future<void> clearUser() async {
    await _userStorage.clearAllItems();
  }
}

import 'package:hive/hive.dart';
import 'package:shining_services_management/models/api/login_user_response.dart';

class HiveStorageService<T> {
  final Box<T> _box;

  // Accept an already opened box via the constructor
  HiveStorageService(this._box);

  HiveStorageService.fromBox(Box<T> box) : _box = box;

  // Create or update an item
  Future<void> saveItem(String key, T item) async {
    await _box.put(key, item);
  }

  // Read an item with a default value if key does not exist
  T? loadItem(String key, {T? defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  // Delete a specific item by key
  Future<void> deleteItem(String key) async {
    await _box.delete(key);
  }

  // Retrieve all items
  List<T> loadAllItems() {
    return _box.values.toList();
  }

  // Clear all items in the box
  Future<void> clearAllItems() async {
    await _box.clear();
  }

  // Check if a key exists
  bool containsKey(String key) {
    return _box.containsKey(key);
  }

  // Close the box when not needed
  Future<void> closeBox() async {
    await _box.close();
  }
}

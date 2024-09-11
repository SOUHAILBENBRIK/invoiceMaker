

import 'package:hive/hive.dart';

class BusinessController {
  // Singleton pattern
  static final BusinessController _instance = BusinessController._internal();

  factory BusinessController() {
    return _instance;
  }

  BusinessController._internal();

  // Box reference
  late Box _box;

  // Initialize the Hive box
  Future<void> initBox() async {
    _box = await Hive.openBox('business');  
  }

  Future<void> addBusiness(String key, BusinessModel) async {
    await _box.put(key, value);
  }

  // Read or Get data from the box
  dynamic getItem(String key) {
    return _box.get(key);
  }

  // Update data in the box
  Future<void> updateItem(String key, dynamic newValue) async {
    await _box.put(key, newValue);
  }

  // Delete data from the box
  Future<void> deleteItem(String key) async {
    await _box.delete(key);
  }
  // Clear all items from the box
  Future<void> clearBox() async {
    await _box.clear();
  }
}

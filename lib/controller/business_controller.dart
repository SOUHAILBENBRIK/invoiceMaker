import 'package:hive/hive.dart';

class BusinessController {
  // Singleton pattern
  static final BusinessController _instance = BusinessController._internal();

  factory BusinessController() {
    return _instance;
  }

  BusinessController._internal();

  // Box references for different entities
  late Box _businessBox;
  late Box _invoiceBox;
  late Box _clientBox;
  late Box _itemBox;
  late Box _estimateBox;

  // Initialize Hive boxes for each entity
  Future<void> initAllBoxes() async {
    _businessBox = await Hive.openBox('business');
    _invoiceBox = await Hive.openBox('invoice');
    _clientBox = await Hive.openBox('client');
    _itemBox = await Hive.openBox('item');
    _estimateBox = await Hive.openBox('estimate');
  }

  // Generic method to add an item to the appropriate box
  Future<void> addItem<T>(String boxName, String key, T value) async {
    var box = _getBox(boxName);
    await box.put(key, value);
  }

  // Generic method to get an item from the appropriate box
  dynamic getItem(String boxName, String key) {
    var box = _getBox(boxName);
    return box.get(key);
  }

  // Generic method to update an item in the appropriate box
  Future<void> updateItem(String boxName, String key, dynamic newValue) async {
    var box = _getBox(boxName);
    await box.put(key, newValue);
  }

  // Generic method to delete an item from the appropriate box
  Future<void> deleteItem(String boxName, String key) async {
    var box = _getBox(boxName);
    await box.delete(key);
  }

  // Get all items from the appropriate box
  List<dynamic> getAllItems(String boxName) {
    var box = _getBox(boxName);
    return box.values.toList();
  }

  // Clear all items from the appropriate box
  Future<void> clearBox(String boxName) async {
    var box = _getBox(boxName);
    await box.clear();
  }

  // Private helper method to retrieve the correct box by name
  Box _getBox(String boxName) {
    switch (boxName) {
      case 'business':
        return _businessBox;
      case 'invoice':
        return _invoiceBox;
      case 'client':
        return _clientBox;
      case 'item':
        return _itemBox;
      case 'estimate':
        return _estimateBox;
      default:
        throw Exception('Invalid box name');
    }
  }
}

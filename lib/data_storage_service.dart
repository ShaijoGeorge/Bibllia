import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataStorageService {
  // Create an instance of FlutterSecureStorage
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Save data securely (encrypted)
  Future<void> saveData(String key, Map<String, dynamic> data) async {
    try {
      // Convert the data to a JSON string
      final jsonString = jsonEncode(data);
      // Save the JSON string securely
      await _secureStorage.write(key: key, value: jsonString);
      print('Data saved securely for key: $key');
    } catch (e) {
      print('Error saving data: $e');
      // Handle the error (e.g., show a message to the user)
    }
  }

  // Load data securely (decrypted)
  Future<Map<String, dynamic>> loadData(String key) async {
    try {
      // Retrieve the JSON string securely
      final jsonString = await _secureStorage.read(key: key);
      if (jsonString != null) {
        // Convert the JSON string back to a Map
        return jsonDecode(jsonString);
      }
      // If no data is found, return an empty Map
      return {};
    } catch (e) {
      print('Error loading data: $e');
      return {}; // Handle the error
    }
  }

  // Delete data securely
  Future<void> deleteData(String key) async {
    try {
      // Delete the data for the given key
      await _secureStorage.delete(key: key);
      print('Data deleted securely for key: $key');
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  // Clear all secure data
  Future<void> clearAllData() async {
    try {
      // Delete all data from secure storage
      await _secureStorage.deleteAll();
      print('All secure data deleted.');
    } catch (e) {
      print('Error clearing data: $e');
    }
  }
}
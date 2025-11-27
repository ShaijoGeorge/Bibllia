import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class ProgressService {
  // Create an instance of FlutterSecureStorage
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Save progress data securely (encrypted)
  Future<void> saveProgress(Map<String, dynamic> progress) async {
    try {
      final jsonString = jsonEncode(progress);
      await _secureStorage.write(key: 'progress', value: jsonString);
      print('Progress saved securely');
    } catch (e) {
      print('Error saving progress: $e');
      // Optionally, show an error message to the user
    }
  }

  // Load progress data securely (decrypted)
  Future<Map<String, dynamic>> getProgress() async {
    try {
      final jsonString = await _secureStorage.read(key: 'progress');
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
      print('No progress data found');
      return {};
    } catch (e) {
      print('Error loading progress: $e');
      return {}; // Handle the error
    }
  }

  // Update a specific field in the progress data
  Future<void> updateProgressField(String key, dynamic value) async {
    try {
      final progress = await getProgress();
      progress[key] = value;
      await saveProgress(progress);
      print('Progress field updated: $key');
    } catch (e) {
      print('Error updating progress field: $e');
    }
  }

  // Reset all progress data
  Future<void> resetProgress() async {
    try {
      await _secureStorage.delete(key: 'progress');
      print('Progress reset successfully');
    } catch (e) {
      print('Error resetting progress: $e');
    }
  }
}
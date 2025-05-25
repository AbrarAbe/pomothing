import 'dart:convert'; // Required for jsonEncode/jsonDecode

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/app_settings.dart';

class SettingsProvider with ChangeNotifier {
  AppSettings _settings = AppSettings(); // Default settings initially
  final String _settingsKey = 'app_settings'; // Key for SharedPreferences
  final SharedPreferences _prefs; // Store the SharedPreferences instance

  AppSettings get settings => _settings;

  SettingsProvider(this._prefs) {
    // Load settings immediately when the provider is created
    _loadSettings();
  }

  // Load settings from SharedPreferences
  void _loadSettings() {
    try {
      final settingsString = _prefs.getString(_settingsKey);
      if (settingsString != null) {
        final settingsMap = jsonDecode(settingsString) as Map<String, dynamic>;
        _settings = AppSettings.fromJson(settingsMap);
        print('Settings loaded: $_settings'); // Debug print
      } else {
        print('No settings found, using defaults: $_settings'); // Debug print
      }
    } catch (e) {
      print('Error loading settings: $e');
      // Fallback to default settings if loading fails
      _settings = AppSettings();
    }
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    try {
      final settingsString = jsonEncode(_settings.toJson());
      await _prefs.setString(_settingsKey, settingsString);
      print('Settings saved: $_settings'); // Debug print
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  // Method to update specific settings
  void updateSettings({
    int? workDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? sessionsBeforeLongBreak,
  }) {
    _settings = _settings.copyWith(
      workDuration: workDuration,
      shortBreakDuration: shortBreakDuration,
      longBreakDuration: longBreakDuration,
      sessionsBeforeLongBreak: sessionsBeforeLongBreak,
    );
    _saveSettings(); // Automatically save settings when updated
    notifyListeners(); // Notify listeners that settings have changed
  }

  // Method to reset settings to defaults
  void resetToDefaults() {
    _settings = AppSettings(); // Create a new instance with default values
    _saveSettings();
    notifyListeners();
  }
}

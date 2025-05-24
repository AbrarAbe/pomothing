import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/app_settings.dart';
import 'settings_provider.dart';
import 'widgets/save_settings_button.dart';
import 'widgets/slider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppSettings _localSettings; // Local state for settings

  @override
  void initState() {
    super.initState();
    // Initialize local settings with current settings from the provider
    final settingsProvider = Provider.of<SettingsProvider>(
      context,
      listen: false,
    );
    _localSettings = settingsProvider.settings;
  }

  void _saveSettings() {
    // Call the provider's update method with local settings
    Provider.of<SettingsProvider>(context, listen: false).updateSettings(
      workDuration: _localSettings.workDuration,
      shortBreakDuration: _localSettings.shortBreakDuration,
      longBreakDuration: _localSettings.longBreakDuration,
      sessionsBeforeLongBreak: _localSettings.sessionsBeforeLongBreak,
    );
    Navigator.pop(context);
  }

  void _resetToDefaults() {
    // Call the provider's reset method
    Provider.of<SettingsProvider>(context, listen: false).resetToDefaults();
    setState(() {
      // Re-initialize local settings with defaults after provider reset
      // Fetching defaults from the provider ensures consistency
      _localSettings =
          Provider.of<SettingsProvider>(context, listen: false).settings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Work Duration Slider
          SettingSlider(
            title: 'Work Duration',
            value:
                (_localSettings.workDuration ~/ 60)
                    .toDouble(), // Convert seconds to minutes
            min: 1,
            max: 60,
            divisions: 59,
            onChanged: (value) {
              setState(() {
                _localSettings = _localSettings.copyWith(
                  workDuration:
                      value.round() * 60, // Convert minutes back to seconds
                );
              });
            },
            displayValue:
                '${_localSettings.workDuration ~/ 60} min', // Display in minutes
          ),
          Divider(
            height: 30,
            thickness: 5,
            color: Theme.of(context).colorScheme.primary,
          ),

          // Short Break Duration Slider
          SettingSlider(
            title: 'Short Break Duration',
            value:
                (_localSettings.shortBreakDuration ~/ 60)
                    .toDouble(), // Convert seconds to minutes
            min: 1,
            max: 30,
            divisions: 29,
            onChanged: (value) {
              setState(() {
                _localSettings = _localSettings.copyWith(
                  shortBreakDuration:
                      value.round() * 60, // Convert minutes back to seconds
                );
              });
            },
            displayValue:
                '${_localSettings.shortBreakDuration ~/ 60} min', // Display in minutes
          ),
          Divider(
            height: 30,
            thickness: 5,
            color: Theme.of(context).colorScheme.primary,
          ),

          // Long Break Duration Slider
          SettingSlider(
            title: 'Long Break Duration',
            value:
                (_localSettings.longBreakDuration ~/ 60)
                    .toDouble(), // Convert seconds to minutes
            min: 5,
            max: 60,
            divisions: 55,
            onChanged: (value) {
              setState(() {
                _localSettings = _localSettings.copyWith(
                  longBreakDuration:
                      value.round() * 60, // Convert minutes back to seconds
                );
              });
            },
            displayValue:
                '${_localSettings.longBreakDuration ~/ 60} min', // Display in minutes
          ),
          Divider(
            height: 30,
            thickness: 5,
            color: Theme.of(context).colorScheme.primary,
          ),

          // Sessions Before Long Break Slider
          SettingSlider(
            title: 'Sessions Before Long Break',
            value: _localSettings.sessionsBeforeLongBreak.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (value) {
              setState(() {
                _localSettings = _localSettings.copyWith(
                  sessionsBeforeLongBreak: value.round(),
                );
              });
            },
            displayValue: '${_localSettings.sessionsBeforeLongBreak}',
          ),
          Divider(
            height: 30,
            thickness: 5,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 20),
          SaveSettingsButton(
            onPressed: _saveSettings, // Call the local save method
            text: 'Save Settings',
            icon: Icons.save,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(height: 20), // Add some spacing
          SaveSettingsButton(
            onPressed: _resetToDefaults, // Call the local save method
            text: 'Reset to Default',
            icon: Icons.restore,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

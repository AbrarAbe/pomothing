import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'models/app_settings.dart';

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
      _localSettings = AppSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Work Duration Slider
          _buildSettingSlider(
            context,
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
          const Divider(),

          // Short Break Duration Slider
          _buildSettingSlider(
            context,
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
          const Divider(),

          // Long Break Duration Slider
          _buildSettingSlider(
            context,
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
          const Divider(),

          // Sessions Before Long Break Slider
          _buildSettingSlider(
            context,
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
          const Divider(),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveSettings, // Call the local save method
            child: const Text('Save Settings'),
          ),
          const SizedBox(height: 10), // Add some spacing
          ElevatedButton(
            onPressed: _resetToDefaults, // Call the local reset method
            child: const Text('Reset to Defaults'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSlider(
    BuildContext context, {
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required String displayValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: value.round().toString(),
                onChanged: onChanged,
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                displayValue,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

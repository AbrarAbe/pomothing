import 'package:flutter/material.dart';
import 'package:pomothing/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert.dart';
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
  late AppSettings _localSettings;

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

  void _resetToDefaults(BuildContext context) async {
    bool? confirmReset = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
          title: const Text('Reset Settings'),
          content: const Text(
            'Are you sure you want to reset all settings to their defaults?',
          ),
          cancelAction: () => Navigator.of(context).pop(false),
          acceptAction: () => Navigator.of(context).pop(true),
          acceptText: 'Reset',
        );
      },
    );

    if (confirmReset == true) {
      Provider.of<SettingsProvider>(context, listen: false).resetToDefaults();
      setState(() {
        _localSettings =
            Provider.of<SettingsProvider>(context, listen: false).settings;
      });
      // TODO: Add motion_toast here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: const Text('Settings'),
        actionsIcon: Icons.restore,
        action: () {
          _resetToDefaults(context);
        },
      ),
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
        ],
      ),
    );
  }
}

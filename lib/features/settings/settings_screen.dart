// ignore_for_file: use_build_context_synchronously

import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter/material.dart';
import 'package:pomothing/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert.dart';
import '../../widgets/toast.dart';
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
  bool _isSaveButtonEnabled = true;

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
    setState(() {
      _isSaveButtonEnabled = false;
    });
    // Call the provider's update method with local settings
    Provider.of<SettingsProvider>(context, listen: false).updateSettings(
      workDuration: _localSettings.workDuration,
      shortBreakDuration: _localSettings.shortBreakDuration,
      longBreakDuration: _localSettings.longBreakDuration,
      sessionsBeforeLongBreak: _localSettings.sessionsBeforeLongBreak,
    );
    Future.delayed(Duration.zero, () {
      DelightToastBar(
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 2),
        builder:
            (context) => Toast(
              icon: Icons.check_circle_outline,
              iconColor: Theme.of(context).colorScheme.onPrimary,
              cardColor: Theme.of(context).colorScheme.tertiary,
              text: "Your settings have been successfully updated!",
              textColor: Theme.of(context).colorScheme.onPrimary,
            ),
      ).show(context);
    });
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
      Future.delayed(Duration.zero, () {
        DelightToastBar(
          autoDismiss: true,
          snackbarDuration: const Duration(seconds: 2),
          builder:
              (context) => Toast(
                icon: Icons.settings_backup_restore,
                iconColor: Theme.of(context).colorScheme.onPrimary,
                cardColor: Theme.of(context).colorScheme.primaryContainer,
                text: "All settings have been restored to their defaults.",
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
        ).show(context);
      });
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
                _isSaveButtonEnabled = true;
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
                _isSaveButtonEnabled = true;
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
                _isSaveButtonEnabled = true;
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
                _isSaveButtonEnabled = true;
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
            onPressed: _isSaveButtonEnabled ? _saveSettings : () {},
            text: 'Save Settings',
            icon: Icons.save,
            color:
                _isSaveButtonEnabled
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

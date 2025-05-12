import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';
import 'features/timer/timer_provider.dart';
import 'features/settings/settings_provider.dart'; // Add this import
import 'features/timer/timer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  final settingsProvider = SettingsProvider(); // Add this line
  final timerProvider = TimerProvider(
    settingsProvider.settings,
  ); // Pass settings to TimerProvider
  await themeProvider.loadTheme();
  // Settings are loaded in the SettingsProvider constructor, no need to call loadSettings here.

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeProvider),
        ChangeNotifierProvider(create: (context) => timerProvider),
        ChangeNotifierProvider(
          create: (context) => settingsProvider,
        ), // Add this provider
      ],
      child: const PomothingApp(),
    ),
  );
}

class PomothingApp extends StatelessWidget {
  const PomothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: TimerScreen(),
    );
  }
}

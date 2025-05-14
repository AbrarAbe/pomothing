import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Keep this import

import 'theme/theme_provider.dart';
import 'features/timer/timer_provider.dart';
import 'features/timer/timer_screen.dart';
import 'features/settings/settings_provider.dart'; // Import SettingsProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create:
              (_) => SettingsProvider(prefs), // SettingsProvider needs prefs
        ),
        // Use ChangeNotifierProxyProvider for TimerProvider
        ChangeNotifierProxyProvider<SettingsProvider, TimerProvider>(
          create:
              (context) => TimerProvider(), // Initial creation (can be basic)
          update: (context, settingsProvider, timerProvider) {
            // This update function is called whenever SettingsProvider notifies listeners
            // or initially when the provider is created.
            timerProvider ??= TimerProvider();
            // Pass the updated settingsProvider to the timerProvider
            timerProvider.updateSettingsProvider(settingsProvider);
            return timerProvider;
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Focus Timer',
            theme: themeProvider.themeData,
            home: const TimerScreen(),
          );
        },
      ),
    );
  }
}

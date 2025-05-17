import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/theme_provider.dart';
import 'features/timer/timer_provider.dart';
import 'features/timer/timer_screen.dart';
import 'features/settings/settings_provider.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initializeNotifications();
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
          create: (_) => SettingsProvider(prefs),
        ),
        ChangeNotifierProxyProvider<SettingsProvider, TimerProvider>(
          create: (context) => TimerProvider(),
          update: (context, settingsProvider, timerProvider) {
            timerProvider ??= TimerProvider();
            timerProvider.updateSettingsProvider(settingsProvider);
            return timerProvider;
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pomothing',
            theme: themeProvider.themeData,
            home: const TimerScreen(),
          );
        },
      ),
    );
  }
}

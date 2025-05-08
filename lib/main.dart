import 'package:flutter/material.dart';
import 'package:pomothing/providers/timer_provider.dart';
import 'package:provider/provider.dart';

import 'screens/timer_screen.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  final timerProvider = TimerProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeProvider),
        ChangeNotifierProvider(create: (context) => timerProvider),
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

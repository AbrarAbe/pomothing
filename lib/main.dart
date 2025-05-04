import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/timer_screen.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
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

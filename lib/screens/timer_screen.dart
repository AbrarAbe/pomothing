import 'package:provider/provider.dart';
import 'package:pomothing/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme(!themeProvider.isDarkMode);
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          spacing: 100,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pomo",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 25,
                  ),
                ),
                Text(
                  "Thing",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10,
                  ),
                ),
              ],
            ),
            NeonCircularTimer(
              width: 250,
              duration: 10,
              controller: _controller,
              isTimerTextShown: true,
              isReverse: true,
              isReverseAnimation: true,
              neumorphicEffect: true,
              backgroundColor: Theme.of(context).colorScheme.surface,
              outerStrokeColor: Theme.of(context).colorScheme.error,
              innerFillGradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
              neonGradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
            ),
            Row(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  onPressed: () {},
                  child: Icon(Icons.stop, size: 25),
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 170,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  child: Icon(Icons.play_arrow, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

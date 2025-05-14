import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';
import '../settings/settings_screen.dart';
import 'timer_provider.dart';
import 'models/timer_state.dart';
import 'widgets/timer_status_header.dart';
import 'widgets/time_display.dart';
import 'widgets/button_row.dart';
import 'widgets/play_pause_button.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    final isRunning = timerProvider.timerState == TimerState.running;

    void handleStop() {
      timerProvider.resetTimer();
    }

    void handlePlayPause() {
      if (isRunning) {
        timerProvider.pauseTimer();
      } else {
        timerProvider.startTimer();
      }
    }

    void handleSkipSession() {
      timerProvider.skipSession();
    }

    void handleResetCycle() {
      timerProvider.resetCycle();
    }

    void navigateToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }

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
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: navigateToSettings,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
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
            const SizedBox(height: 70),
            TimeDisplay(remainingTime: timerProvider.remainingTime),
            const SizedBox(height: 10),
            TimerStatusHeader(
              currentSessionType: timerProvider.currentSessionType,
              skipSession: handleSkipSession,
              currentCycle: timerProvider.currentCycle,
            ),
            const SizedBox(height: 60),
            ButtonRow(
              handleResetCycle: handleResetCycle,
              handleStop: handleStop,
            ),
            const SizedBox(height: 20),
            PlayPauseButton(
              timerState: timerProvider.timerState,
              handlePlayPause: handlePlayPause,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

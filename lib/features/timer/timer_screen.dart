import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_provider.dart';
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

    void handleResetCycle() {
      timerProvider.resetCycle();
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
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerStatusHeader(
              currentSessionType: timerProvider.currentSessionType,
              skipSession: timerProvider.skipSession,
              currentCycle: timerProvider.currentCycle,
            ),
            const SizedBox(height: 50),
            TimeDisplay(remainingTime: timerProvider.remainingTime),
            const SizedBox(height: 50),
            ButtonRow(
              handleResetCycle: handleResetCycle,
              handleStop: handleStop,
            ),
            const SizedBox(height: 20),
            PlayPauseButton(
              timerState: timerProvider.timerState,
              handlePlayPause: handlePlayPause,
            ),
            const SizedBox(height: 50),
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

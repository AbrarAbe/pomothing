import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../models/timer_state.dart';
import '../models/session_type.dart';
import '../theme/theme_provider.dart';

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

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  IconData _getPlayPauseIcon(TimerState state) {
    if (state == TimerState.running) {
      return Icons.pause;
    } else {
      return Icons.play_arrow;
    }
  }

  // String _getPlayPauseButtonText(TimerState state) {
  //   if (state == TimerState.running) {
  //     return 'Pause';
  //   } else if (state == TimerState.paused) {
  //     return 'Resume';
  //   } else {
  //     return 'Start';
  //   }
  // }

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
                const SizedBox(height: 20),
                Row(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timerProvider.currentSessionType == SessionType.work
                          ? "Work Session"
                          : timerProvider.currentSessionType ==
                              SessionType.shortBreak
                          ? "Short Break"
                          : "Long Break",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      color: Theme.of(context).colorScheme.tertiary,
                      onPressed: () {
                        timerProvider.skipSession();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Cycle: ${timerProvider.currentCycle}",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(90),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Text(
              _formatTime(timerProvider.remainingTime),
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.onTertiary,
                  onPressed: handleResetCycle,
                  child: Icon(
                    Icons.restart_alt,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 25),
                MaterialButton(
                  height: 50,
                  minWidth: 170,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  onPressed: handleStop,
                  child: Icon(
                    Icons.stop,
                    size: 25,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 50,
              minWidth: 290,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).colorScheme.primary,
              onPressed: handlePlayPause,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getPlayPauseIcon(timerProvider.timerState),
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              ),
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

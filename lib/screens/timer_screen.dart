import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

import '../providers/timer_provider.dart';
import '../models/timer_state.dart';
import '../models/session_type.dart';
// import 'package:pomothing/utils/timer_utils.dart';
import '../theme/theme_provider.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final CompleteCreation _controller = CompleteCreation();
  @override
  void initState() {
    super.initState();
  }

  int _getCurrentSessionDuration(TimerProvider timerProvider) {
    if (timerProvider.currentSessionType == SessionType.work) {
      return 25 * 60;
    } else if (timerProvider.currentSessionType == SessionType.shortBreak) {
      return 5 * 60;
    } else {
      return 15 * 60;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    final isRunning = timerProvider.timerState == TimerState.running;
    final isPaused = timerProvider.timerState == TimerState.paused;
    final isInitial = timerProvider.timerState == TimerState.initial;
    // final isStopped = timerProvider.timerState == TimerState.stopped;

    void onStopButtonPressed() {
      timerProvider.resetTimer();
      _controller.restart();
    }

    void onPlayButtonPressed() {
      if (isRunning) {
        timerProvider.pauseTimer();
        _controller.pause();
      } else if (isPaused || isInitial) {
        timerProvider.startTimer();
        _controller.play();
      }
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
                const SizedBox(height: 20),
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
            NeonCircularTimer(
              width: 250,
              duration: _getCurrentSessionDuration(timerProvider),
              controller: _controller,
              isTimerTextShown: true,
              isReverse: true,
              isReverseAnimation: true,
              neumorphicEffect: true,
              textStyle: TextStyle(
                fontSize: 50,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              outerStrokeColor: Theme.of(context).colorScheme.onPrimary,
              innerFillGradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.onTertiary,
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
              neonGradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
              onComplete: () {
                timerProvider.endSession();
              },
            ),
            Row(
              spacing: 25,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stop / reset button
                MaterialButton(
                  height: 50,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  onPressed: onStopButtonPressed,
                  child: Icon(
                    Icons.stop,
                    size: 25,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                // Play / pause button
                MaterialButton(
                  height: 50,
                  minWidth: 170,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: onPlayButtonPressed,
                  child: Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

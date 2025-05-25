import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';
import '../../widgets/appbar.dart';
import '../../widgets/toast.dart';
import '../settings/settings_screen.dart';
import 'models/session_type.dart';
import 'models/timer_state.dart';
import 'timer_provider.dart';
import 'widgets/button_row.dart';
import 'widgets/play_pause_button.dart';
import 'widgets/time_display.dart';
import 'widgets/timer_status_header.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  TimerState? _previousTimerState;
  SessionType? _previousSessionType;
  bool _buttonPressed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timerProvider = Provider.of<TimerProvider>(context);

    final bool sessionJustEnded =
        (_previousTimerState == TimerState.running ||
            _previousTimerState == TimerState.paused) &&
        timerProvider.timerState == TimerState.initial &&
        _previousSessionType != timerProvider.currentSessionType &&
        !_buttonPressed;

    if (sessionJustEnded) {
      _showSessionEndToast(context);
    }

    _previousTimerState = timerProvider.timerState;
    _previousSessionType = timerProvider.currentSessionType;
    // Reset the flag after checking
    _buttonPressed = false;
  }

  void _showSessionEndToast(BuildContext context) {
    String message;
    Color color;
    IconData icon;
    SessionType nextSessionType =
        Provider.of<TimerProvider>(context, listen: false).currentSessionType;
    switch (nextSessionType) {
      case SessionType.work:
        message = 'Break over! Time to Focus!';
        color = Theme.of(context).colorScheme.onPrimary;
        icon = Icons.alarm_off;
        break;
      case SessionType.shortBreak:
        message = 'Work session complete! Take a Short Break.';
        color = Theme.of(context).colorScheme.primary;
        icon = Icons.free_breakfast;
        break;
      case SessionType.longBreak:
        message = 'Work session complete! Take a Long Break.';
        color = Theme.of(context).colorScheme.primary;
        icon = Icons.local_cafe;
        break;
    }
    DelightToastBar(
      builder:
          (context) => Toast(
            icon: icon,
            iconColor: Theme.of(context).colorScheme.onPrimary,
            cardColor: color,
            text: message,
            textColor: Theme.of(context).colorScheme.onPrimary,
          ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final isRunning = timerProvider.timerState == TimerState.running;

    void handleStop() {
      _buttonPressed = true;
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
      _buttonPressed = true;
      timerProvider.skipSession();
    }

    void handleResetCycle() {
      _buttonPressed = true;
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
      appBar: AppBarWidget(
        widget: Consumer<ThemeProvider>(
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
        action: navigateToSettings,
        actionsIcon: Icons.settings,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final isLargeScreen =
                screenWidth >= 600; // Tablet and PC breakpoint

            Widget timerAndButtons;
            if (isLargeScreen) {
              timerAndButtons = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TimeDisplay(remainingTime: timerProvider.remainingTime),
                  const SizedBox(width: 40), // Space between timer and buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonRow(
                        handleResetCycle: handleResetCycle,
                        handleStop: handleStop,
                      ),
                      const SizedBox(height: 20),
                      PlayPauseButton(
                        timerState: timerProvider.timerState,
                        handlePlayPause: handlePlayPause,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              // Mobile layout
              timerAndButtons = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimeDisplay(remainingTime: timerProvider.remainingTime),
                  const SizedBox(height: 20),
                  ButtonRow(
                    handleResetCycle: handleResetCycle,
                    handleStop: handleStop,
                  ),
                  const SizedBox(height: 20),
                  PlayPauseButton(
                    timerState: timerProvider.timerState,
                    handlePlayPause: handlePlayPause,
                  ),
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Text(
                  "Pomo",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 20,
                  ),
                ),
                Text(
                  "Thing",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 12,
                  ),
                ),
                const Spacer(flex: 2),
                timerAndButtons,
                const SizedBox(height: 24),
                TimerStatusHeader(
                  currentSessionType: timerProvider.currentSessionType,
                  skipSession: handleSkipSession,
                  currentCycle: timerProvider.currentCycle,
                ),
                const Spacer(flex: 4),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings_screen.dart';
import 'timer_provider.dart';
import 'models/timer_state.dart';
import 'models/session_type.dart';
import 'widgets/appbar.dart';
import 'widgets/session_end_message.dart';
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
  TimerState? _previousTimerState;
  SessionType? _previousSessionType;
  String? _sessionEndMessage;
  Color? _sessionEndMessageColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timerProvider = Provider.of<TimerProvider>(context);

    final bool sessionJustEnded =
        (_previousTimerState == TimerState.running ||
            _previousTimerState == TimerState.paused) &&
        timerProvider.timerState == TimerState.initial &&
        _previousSessionType != timerProvider.currentSessionType;

    if (sessionJustEnded) {
      _updateSessionEndMessage(timerProvider.currentSessionType);
    }

    _previousTimerState = timerProvider.timerState;
    _previousSessionType = timerProvider.currentSessionType;
  }

  void _updateSessionEndMessage(SessionType nextSessionType) {
    String message;
    Color color;
    switch (nextSessionType) {
      case SessionType.work:
        message = 'Break over! Time to Focus!';
        color = Theme.of(context).colorScheme.error;
        break;
      case SessionType.shortBreak:
        message = 'Work session complete! Take a Short Break.';
        color = Theme.of(context).colorScheme.tertiary;
        break;
      case SessionType.longBreak:
        message = 'Work session complete! Take a Long Break.';
        color = Theme.of(context).colorScheme.tertiary;
        break;
    }

    setState(() {
      _sessionEndMessage = message;
      _sessionEndMessageColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final isRunning = timerProvider.timerState == TimerState.running;

    void dismissSessionEndMessage() {
      setState(() {
        _sessionEndMessage = null;
      });
    }

    void handleStop() {
      timerProvider.resetTimer();
    }

    void handlePlayPause() {
      if (isRunning) {
        timerProvider.pauseTimer();
      } else {
        timerProvider.startTimer();
        dismissSessionEndMessage();
      }
    }

    void handleSkipSession() {
      timerProvider.skipSession();
      dismissSessionEndMessage();
    }

    void handleResetCycle() {
      timerProvider.resetCycle();
      dismissSessionEndMessage();
    }

    void navigateToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBarWidget(navigateToSettings: navigateToSettings),
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
            if (_sessionEndMessage != null) const SizedBox(height: 10),
            if (_sessionEndMessage != null)
              SessionEndMessage(
                sessionEndMessage: _sessionEndMessage,
                sessionEndMessageColor: _sessionEndMessageColor,
              ),
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
}

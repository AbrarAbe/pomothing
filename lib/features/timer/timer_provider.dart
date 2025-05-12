import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import '../settings/models/app_settings.dart'; // Import AppSettings
import 'models/session_type.dart';
import 'models/timer_state.dart';

class TimerProvider extends ChangeNotifier {
  late Timer _timer;
  int _timeRemaining;
  TimerState _timerState = TimerState.initial;
  SessionType _currentSessionType = SessionType.work;
  int _currentCycle = 0;

  // Remove hardcoded durations and cycles
  // final int _workDuration = 25 * 60;
  // final int _shortBreakDuration = 5 * 60;
  // final int _longBreakDuration = 15 * 60;
  // final int _cyclesBeforeLongBreak = 4;

  final AppSettings _settings; // Add a field to hold settings

  TimerProvider(this._settings)
    : _timeRemaining = _settings.workDuration * 60; // Initialize with settings

  AppSettings get settings => _settings; // Expose settings if needed

  int get timeRemaining => _timeRemaining;
  TimerState get timerState => _timerState;
  SessionType get currentSessionType => _currentSessionType;
  int get currentCycle => _currentCycle;
  int get remainingTime => _timeRemaining;

  void _cancelTimer() {
    if (_timerState == TimerState.running && _timer.isActive) {
      _timer.cancel();
    }
  }

  void startTimer() {
    if (_timerState == TimerState.running) return;
    _timerState = TimerState.running;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
        notifyListeners();
      } else {
        endSession();
      }
    });
  }

  void pauseTimer() {
    if (_timerState != TimerState.running) return;

    _timer.cancel();
    _timerState = TimerState.paused;
    notifyListeners();
  }

  void resumeTimer() {
    if (_timerState != TimerState.paused) return;
    startTimer();
  }

  void resetTimer() {
    _cancelTimer();
    _timeRemaining = _getDurationForSessionType(_currentSessionType);
    _timerState = TimerState.initial;
    notifyListeners();
  }

  void resetCycle() {
    _cancelTimer();
    _currentSessionType = SessionType.work;
    _currentCycle = 0;
    _timeRemaining = _settings.workDuration * 60; // Use settings
    _timerState = TimerState.initial;
    notifyListeners();
  }

  void skipSession() {
    _cancelTimer();
    if (_currentSessionType == SessionType.work) {
      _currentCycle++;
      if (_currentCycle % _settings.sessionsBeforeLongBreak == 0) {
        // Use settings
        _currentSessionType = SessionType.longBreak;
        _timeRemaining = _settings.longBreakDuration * 60; // Use settings
      } else {
        _currentSessionType = SessionType.shortBreak;
        _timeRemaining = _settings.shortBreakDuration * 60; // Use settings
      }
    } else {
      _currentSessionType = SessionType.work;
      _timeRemaining = _settings.workDuration * 60; // Use settings
    }

    _timerState = TimerState.initial;
    notifyListeners();
  }

  void endSession() {
    _cancelTimer();
    if (_currentSessionType == SessionType.work) {
      _currentCycle++;
      if (_currentCycle % _settings.sessionsBeforeLongBreak == 0) {
        // Use settings
        _currentSessionType = SessionType.longBreak;
        _timeRemaining = _settings.longBreakDuration * 60; // Use settings
      } else {
        _currentSessionType = SessionType.shortBreak;
        _timeRemaining = _settings.shortBreakDuration * 60; // Use settings
      }
    } else {
      _currentSessionType = SessionType.work;
      _timeRemaining = _settings.workDuration * 60; // Use settings
    }

    _timerState = TimerState.initial;
    notifyListeners();
  }

  int _getDurationForSessionType(SessionType type) {
    switch (type) {
      case SessionType.work:
        return _settings.workDuration * 60; // Use settings
      case SessionType.shortBreak:
        return _settings.shortBreakDuration * 60; // Use settings
      case SessionType.longBreak:
        return _settings.longBreakDuration * 60; // Use settings
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _cancelTimer();
    super.dispose();
  }
}

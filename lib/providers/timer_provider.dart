import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import '../models/session_type.dart';
import '../models/timer_state.dart';

class TimerProvider extends ChangeNotifier {
  late Timer _timer;
  int _timeRemaining;
  TimerState _timerState = TimerState.initial;
  SessionType _currentSessionType = SessionType.work;
  int _currentCycle = 0;

  final int _workDuration = 25 * 60;
  final int _shortBreakDuration = 5 * 60;
  final int _longBreakDuration = 15 * 60;
  final int _cyclesBeforeLongBreak = 4;

  TimerProvider() : _timeRemaining = 25 * 60;

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
    _timeRemaining = _workDuration;
    _timerState = TimerState.initial;
    notifyListeners();
  }

  void skipSession() {
    _cancelTimer();
    if (_currentSessionType == SessionType.work) {
      _currentCycle++;
      if (_currentCycle % _cyclesBeforeLongBreak == 0) {
        _currentSessionType = SessionType.longBreak;
        _timeRemaining = _longBreakDuration;
      } else {
        _currentSessionType = SessionType.shortBreak;
        _timeRemaining = _shortBreakDuration;
      }
    } else {
      _currentSessionType = SessionType.work;
      _timeRemaining = _workDuration;
    }

    _timerState = TimerState.initial;
    notifyListeners();
  }

  void endSession() {
    _cancelTimer();
    if (_currentSessionType == SessionType.work) {
      _currentCycle++;
      if (_currentCycle % _cyclesBeforeLongBreak == 0) {
        _currentSessionType = SessionType.longBreak;
        _timeRemaining = _longBreakDuration;
      } else {
        _currentSessionType = SessionType.shortBreak;
        _timeRemaining = _shortBreakDuration;
      }
    } else {
      _currentSessionType = SessionType.work;
      _timeRemaining = _workDuration;
    }

    _timerState = TimerState.initial;
    notifyListeners();
  }

  int _getDurationForSessionType(SessionType type) {
    switch (type) {
      case SessionType.work:
        return _workDuration;
      case SessionType.shortBreak:
        return _shortBreakDuration;
      case SessionType.longBreak:
        return _longBreakDuration;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _cancelTimer();
    super.dispose();
  }
}

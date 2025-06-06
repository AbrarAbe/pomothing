import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart'; // Import just_audio
import 'package:timezone/timezone.dart' as tz; // Import timezone

import '../../services/notification_service.dart'; // Import NotificationService
import '../settings/models/app_settings.dart';
import '../settings/settings_provider.dart';
import 'models/session_type.dart';
import 'models/timer_state.dart';

class TimerProvider with ChangeNotifier {
  final NotificationService _notificationService =
      NotificationService(); // Create an instance
  late Timer _timer;
  TimerState _timerState = TimerState.initial;
  SessionType _currentSessionType = SessionType.work;
  int _remainingTime = 0;
  int _currentCycle = 1;
  late SettingsProvider _settingsProvider;
  late AudioPlayer _audioPlayer;

  TimerProvider() {
    // Initialize the audio player and load the sound
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    try {
      // Load the audio file from assets
      await _audioPlayer.setAsset('assets/audio/bell.m4a');
      await _audioPlayer.setVolume(1.0);
    } catch (e) {
      // Handle errors, e.g., file not found
      print("Error loading audio asset: $e");
    }
  }

  void updateSettingsProvider(SettingsProvider newSettingsProvider) {
    _settingsProvider = newSettingsProvider;

    final AppSettings currentSettings = _settingsProvider.settings;

    if (_timerState == TimerState.initial || _timerState == TimerState.paused) {
      final int newRemainingTime = _getDurationForSessionType(
        _currentSessionType,
        currentSettings,
      );

      if (_remainingTime != newRemainingTime) {
        _remainingTime = newRemainingTime;
        notifyListeners();
      }
    }
  }

  int _getDurationForSessionType(SessionType type, AppSettings settings) {
    switch (type) {
      case SessionType.work:
        return settings.workDuration;
      case SessionType.shortBreak:
        return settings.shortBreakDuration;
      case SessionType.longBreak:
        return settings.longBreakDuration;
    }
  }

  int get timeRemaining => _remainingTime;
  TimerState get timerState => _timerState;
  SessionType get currentSessionType => _currentSessionType;
  int get currentCycle => _currentCycle;
  int get remainingTime => _remainingTime;

  void startTimer() {
    if (_timerState == TimerState.initial || _timerState == TimerState.paused) {
      _timerState = TimerState.running;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          _remainingTime--;
          notifyListeners();
        } else {
          _timer.cancel();
          _handleSessionEnd();
        }
      });
      notifyListeners();
    }
  }

  void _cancelTimer() {
    if (_timerState == TimerState.running && _timer.isActive) {
      _timer.cancel();
    }
  }

  void pauseTimer() {
    if (_timerState == TimerState.running) {
      _timerState = TimerState.paused;
      _timer.cancel();
      notifyListeners();
    }
  }

  void resetTimer() {
    _cancelTimer();
    _timerState = TimerState.initial;
    final settings = _settingsProvider.settings;
    _remainingTime = _getDurationForSessionType(currentSessionType, settings);
    notifyListeners();
    // Optional: Stop audio playback if it was somehow playing
    _audioPlayer.stop();
  }

  void skipSession() {
    _cancelTimer();
    final settings = _settingsProvider.settings;

    if (_currentSessionType == SessionType.work) {
      if (_currentCycle < settings.sessionsBeforeLongBreak) {
        _currentSessionType = SessionType.shortBreak;
      } else {
        _currentSessionType = SessionType.longBreak;
        _currentCycle = 0;
      }
    } else {
      _currentSessionType = SessionType.work;
      if (_currentCycle > 0) {
        _currentCycle++;
      } else {
        _currentCycle = 1;
      }
    }
    _remainingTime = _getDurationForSessionType(_currentSessionType, settings);
    _timerState = TimerState.initial;
    notifyListeners();
  }

  void resetCycle() {
    _cancelTimer();
    _currentCycle = 1;
    _currentSessionType = SessionType.work;
    final settings = _settingsProvider.settings;
    _remainingTime = _getDurationForSessionType(SessionType.work, settings);
    _timerState = TimerState.initial;
    notifyListeners();
    // Optional: Stop audio playback
    _audioPlayer.stop();
  }

  void _handleSessionEnd() {
    // Determine the type of session that just ended (before skipping)
    final SessionType endedSessionType = _currentSessionType;

    // Play the audio when a session ends
    _playCompletionSound();

    // Schedule a notification for the session end
    _scheduleSessionEndNotification(endedSessionType);

    // Skip to the next session after handling the end
    skipSession();
  }

  void _scheduleSessionEndNotification(SessionType sessionType) {
    debugPrint(
      'Attempting to schedule notification for session type: $sessionType',
    ); // Debug print
    String title;
    String body;

    switch (sessionType) {
      case SessionType.work:
        title = 'Work Session Complete!';
        body = 'Time for a break.';
        break;
      case SessionType.shortBreak:
        title = 'Short Break Complete!';
        body = 'Time to get back to work.';
        break;
      case SessionType.longBreak:
        title = 'Long Break Complete!';
        body = 'Time to get back to work.';
        break;
    }

    // Schedule the notification for the current time
    _notificationService.scheduleNotification(
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.now(
        tz.local,
      ).add(const Duration(seconds: 1)), // Schedule 1 seconds in the future
    );
  }

  void _playCompletionSound() async {
    try {
      // Seek to the beginning to play from start every time
      await _audioPlayer.seek(Duration.zero);
      // Play the sound
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    // Dispose the audio player
    _audioPlayer.dispose();
    super.dispose();
  }
}

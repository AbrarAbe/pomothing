class AppSettings {
  final int workDuration; // in seconds
  final int shortBreakDuration; // in seconds
  final int longBreakDuration; // in seconds
  final int sessionsBeforeLongBreak;
  // Add other settings here later (e.g., bool enableNotifications, bool enableSounds)

  AppSettings({
    this.workDuration = 25 * 60, // Default 25 minutes
    this.shortBreakDuration = 5 * 60, // Default 5 minutes
    this.longBreakDuration = 15 * 60, // Default 15 minutes
    this.sessionsBeforeLongBreak = 4, // Default 4 sessions
  });

  // Basic factory method to create from a Map (useful for SharedPreferences or other sources)
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      workDuration: json['workDuration'] ?? 25 * 60,
      shortBreakDuration: json['shortBreakDuration'] ?? 5 * 60,
      longBreakDuration: json['longBreakDuration'] ?? 15 * 60,
      sessionsBeforeLongBreak: json['sessionsBeforeLongBreak'] ?? 4,
    );
  }

  // Basic method to convert to a Map (useful for SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'workDuration': workDuration,
      'shortBreakDuration': shortBreakDuration,
      'longBreakDuration': longBreakDuration,
      'sessionsBeforeLongBreak': sessionsBeforeLongBreak,
    };
  }

  // toString for debugging
  @override
  String toString() {
    return 'AppSettings(workDuration: $workDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration, sessionsBeforeLongBreak: $sessionsBeforeLongBreak)';
  }

  // CopyWith method for creating modified copies (useful for immutability)
  AppSettings copyWith({
    int? workDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? sessionsBeforeLongBreak,
  }) {
    return AppSettings(
      workDuration: workDuration ?? this.workDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      sessionsBeforeLongBreak:
          sessionsBeforeLongBreak ?? this.sessionsBeforeLongBreak,
    );
  }
}

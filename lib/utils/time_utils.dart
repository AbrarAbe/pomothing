String formatMinutes(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  return minutes;
}

String formatSeconds(int seconds) {
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
  return remainingSeconds;
}

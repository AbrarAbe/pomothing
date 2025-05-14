import 'package:flutter/material.dart';

import '../models/timer_state.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.timerState,
    required this.handlePlayPause,
  });

  final TimerState timerState;
  final VoidCallback handlePlayPause;

  @override
  Widget build(BuildContext context) {
    IconData getPlayPauseIcon(TimerState state) {
      if (state == TimerState.running) {
        return Icons.pause;
      } else {
        return Icons.play_arrow;
      }
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(290, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).colorScheme.primary, // Button color
        foregroundColor:
            Theme.of(context).colorScheme.onPrimary, // Icon/text color
      ),
      onPressed: handlePlayPause,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            getPlayPauseIcon(timerState),
            size: 30,
          ),
        ],
      ),
    );
  }
}

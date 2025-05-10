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

    return MaterialButton(
      height: 50,
      minWidth: 290,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Theme.of(context).colorScheme.primary,
      onPressed: handlePlayPause,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            getPlayPauseIcon(timerState),
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}

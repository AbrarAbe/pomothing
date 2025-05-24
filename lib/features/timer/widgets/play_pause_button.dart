import 'package:flutter/material.dart';

import '../models/timer_state.dart';
import '/../widgets/press_animated_button.dart';

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

    return PressAnimatedButton(
      onPressed: handlePlayPause,
      child: Container(
        width: 290,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getPlayPauseIcon(timerState),
              size: 30,
              color: Theme.of(context).colorScheme.surface, // Apply icon color
            ),
          ],
        ),
      ),
    );
  }
}

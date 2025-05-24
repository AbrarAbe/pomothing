import 'package:flutter/material.dart';

import '/../widgets/press_animated_button.dart';

class ButtonRow extends StatelessWidget {
  final VoidCallback handleResetCycle;
  final VoidCallback handleStop;
  const ButtonRow({
    super.key,
    required this.handleResetCycle,
    required this.handleStop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PressAnimatedButton(
          onPressed: handleResetCycle,
          child: Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.onTertiary,
            ),
            child: Icon(
              Icons.restart_alt,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        PressAnimatedButton(
          onPressed: handleStop,
          child: Container(
            width: 170,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Icon(
              Icons.stop,
              size: 25,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

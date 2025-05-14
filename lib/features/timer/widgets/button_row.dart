import 'package:flutter/material.dart';

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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
          ),
          onPressed: handleResetCycle,
          child: Icon(
            Icons.restart_alt,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(170, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          onPressed: handleStop,
          child: Icon(
            Icons.stop,
            size: 25,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}

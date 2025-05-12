import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    super.key,
    required this.handleResetCycle,
    required this.handleStop,
  });

  final VoidCallback handleResetCycle;
  final VoidCallback handleStop;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          height: 50,
          minWidth: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).colorScheme.onTertiary,
          onPressed: handleResetCycle,
          child: Icon(
            Icons.restart_alt,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        MaterialButton(
          height: 50,
          minWidth: 170,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
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

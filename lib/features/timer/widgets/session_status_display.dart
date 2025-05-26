import 'package:flutter/material.dart';

import '../models/session_type.dart';

class SessionInfo extends StatelessWidget {
  const SessionInfo({
    super.key,
    required this.currentSessionType,
    required this.skipSession,
    required this.currentCycle,
    required this.fontSize, // Add fontSize parameter
  });

  final SessionType currentSessionType;
  final VoidCallback skipSession;
  final int currentCycle;
  final double fontSize; // Store fontSize

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        spacing: 2,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentSessionType == SessionType.work
                ? "Work Session"
                : currentSessionType == SessionType.shortBreak
                ? "Short Break"
                : "Long Break",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: fontSize, // Use the provided fontSize
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            color: Theme.of(context).colorScheme.tertiary,
            onPressed: () {
              skipSession();
            },
          ),
        ],
      ),
    );
  }
}

class CycleCount extends StatelessWidget {
  const CycleCount({
    super.key,
    required this.currentCycle,
    required this.fontSize, // Add fontSize parameter
  });

  final int currentCycle;
  final double fontSize; // Store fontSize

  @override
  Widget build(BuildContext context) {
    return Text(
      "Cycle: $currentCycle",
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(90),
        fontSize: fontSize, // Use the provided fontSize
      ),
    );
  }
}

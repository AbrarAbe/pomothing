import 'package:flutter/material.dart';
import '../models/session_type.dart';
import 'session_status_display.dart';

class TimerStatusHeader extends StatelessWidget {
  const TimerStatusHeader({
    super.key,
    required this.currentSessionType,
    required this.skipSession,
    required this.currentCycle,
  });

  final SessionType currentSessionType;
  final VoidCallback skipSession;
  final int currentCycle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pomo",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 40,
            fontWeight: FontWeight.w200,
            letterSpacing: 25,
          ),
        ),
        Text(
          "Thing",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
          ),
        ),
        const SizedBox(height: 20),
        SessionInfo(
          currentSessionType: currentSessionType,
          skipSession: skipSession,
          currentCycle: currentCycle,
        ),
        const SizedBox(height: 10),
        CycleCount(currentCycle: currentCycle),
      ],
    );
  }
}

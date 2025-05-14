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
        SessionInfo(
          currentSessionType: currentSessionType,
          skipSession: skipSession,
          currentCycle: currentCycle,
        ),
        CycleCount(currentCycle: currentCycle),
      ],
    );
  }
}

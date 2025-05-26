import 'package:flutter/material.dart';

import '../models/session_type.dart';
import 'session_status_display.dart';

class TimerStatusHeader extends StatelessWidget {
  const TimerStatusHeader({
    super.key,
    required this.currentSessionType,
    required this.skipSession,
    required this.currentCycle,
    required this.sessionInfoFontSize, // Add sessionInfoFontSize parameter
    required this.cycleCountFontSize, // Add cycleCountFontSize parameter
  });

  final SessionType currentSessionType;
  final VoidCallback skipSession;
  final int currentCycle;
  final double sessionInfoFontSize; // Store sessionInfoFontSize
  final double cycleCountFontSize; // Store cycleCountFontSize

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SessionInfo(
          currentSessionType: currentSessionType,
          skipSession: skipSession,
          currentCycle: currentCycle,
          fontSize: sessionInfoFontSize, // Pass sessionInfoFontSize
        ),
        CycleCount(
          currentCycle: currentCycle,
          fontSize: cycleCountFontSize, // Pass cycleCountFontSize
        ),
      ],
    );
  }
}

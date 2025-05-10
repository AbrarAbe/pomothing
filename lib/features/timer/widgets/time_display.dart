import 'package:flutter/material.dart';
import '../../../utils/time_utils.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({super.key, required this.remainingTime});

  final int remainingTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTime(remainingTime),
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

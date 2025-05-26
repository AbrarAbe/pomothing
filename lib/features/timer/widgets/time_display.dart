import 'package:flutter/material.dart';

import '../../../utils/time_utils.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({
    super.key,
    required this.remainingTime,
    // required this.padding,
    required this.fontSize, // Add fontSize parameter
  });

  final int remainingTime;
  final double fontSize; // Store fontSize

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: fontSize, // Use the provided fontSize
      fontWeight: FontWeight.bold,
      color: Colors.white70,
    );
    return Container(
      width: 290,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            alignment: Alignment.center,
            child: Text(formatMinutes(remainingTime), style: textStyle),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: Text(
              ':',
              style: TextStyle(
                fontSize: fontSize, // Use the provided fontSize
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
          ),
          Container(
            width: 110,
            alignment: Alignment.center,
            child: Text(formatSeconds(remainingTime), style: textStyle),
          ),
        ],
      ),
    );
  }
}

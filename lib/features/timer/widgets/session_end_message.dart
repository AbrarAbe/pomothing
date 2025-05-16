import 'package:flutter/material.dart';

class SessionEndMessage extends StatelessWidget {
  const SessionEndMessage({
    super.key,
    required String? sessionEndMessage,
    required Color? sessionEndMessageColor,
  }) : _sessionEndMessage = sessionEndMessage,
       _sessionEndMessageColor = sessionEndMessageColor;

  final String? _sessionEndMessage;
  final Color? _sessionEndMessageColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Text(
        _sessionEndMessage!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: _sessionEndMessageColor),
      ),
    );
  }
}

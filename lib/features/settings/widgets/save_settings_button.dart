import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveSettingsButton extends StatelessWidget {
  final Color color;
  void Function() onPressed;
  final String text;
  final IconData? icon;
  SaveSettingsButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(290, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: color, // Button color
        foregroundColor:
            Theme.of(context).colorScheme.onPrimary, // Icon/text color
      ),
      onPressed: onPressed,
      child: Row(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Icon(icon, size: 20),
        ],
      ),
    );
  }
}

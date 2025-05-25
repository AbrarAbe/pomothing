import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? cardColor;
  final String text;
  final Color? textColor;

  const Toast({
    super.key,
    required this.icon,
    this.iconColor,
    this.cardColor,
    required this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ToastCard(
      leading: Icon(icon, size: 28, color: iconColor),
      color: cardColor,
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: textColor,
        ),
      ),
    );
  }
}

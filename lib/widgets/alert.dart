import 'package:flutter/material.dart';

import 'press_animated_button.dart';

class AlertWidget extends StatelessWidget {
  final Text title;
  final Widget content;
  final void Function()? cancelAction;
  final void Function()? acceptAction;
  final String acceptText;

  const AlertWidget({
    super.key,
    required this.title,
    required this.content,
    this.cancelAction,
    required this.acceptAction,
    required this.acceptText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        PressAnimatedButton(
          scaleFactor: 0.8,
          onPressed: cancelAction,
          child:
              cancelAction != null
                  ? Container(
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
        PressAnimatedButton(
          scaleFactor: 0.8,
          onPressed: acceptAction,
          child: Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              acceptText,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}

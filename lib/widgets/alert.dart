import 'package:flutter/material.dart';

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
        TextButton(
          onPressed: cancelAction,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.error,
            ),
          ),
          child:
              cancelAction != null
                  ? const Text('Cancel')
                  : const SizedBox.shrink(),
        ),
        TextButton(
          onPressed: acceptAction,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.error,
            ),
          ),
          child: Text(acceptText),
        ),
      ],
    );
  }
}

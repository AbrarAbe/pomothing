import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingAction;
  final Text? title;
  final IconData? actionsIcon;
  final void Function()? action;
  final Widget? widget;
  const AppBarWidget({
    super.key,
    this.leadingAction,
    this.title,
    this.widget,
    this.actionsIcon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingAction,
      title: title,
      actions: [
        widget ?? const SizedBox.shrink(),
        IconButton(
          padding: const EdgeInsets.only(right: 20.0),
          icon: Icon(actionsIcon),
          onPressed: action,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

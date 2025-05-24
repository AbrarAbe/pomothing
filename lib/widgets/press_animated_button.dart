import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed for haptic feedback

class PressAnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final double scaleFactor;

  const PressAnimatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.duration = const Duration(milliseconds: 150),
    this.scaleFactor = 0.95,
  });

  @override
  State<PressAnimatedButton> createState() => _PressAnimatedButtonState();
}

class _PressAnimatedButtonState extends State<PressAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handlePress() async {
    // Only animate and trigger if onPressed is not null
    if (widget.onPressed != null) {
      // Vibrate slightly
      HapticFeedback.lightImpact();

      // Animate down
      await _controller.forward();
      // Animate back up
      await _controller.reverse();

      // Call the original onPressed function after animation completes
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use GestureDetector to capture taps for animation
    return GestureDetector(
      onTapDown: (_) {
        if (widget.onPressed != null) {
          _controller.forward();
        }
      },
      onTapUp: (_) {
        if (widget.onPressed != null) {
          _controller.reverse();
        }
      },
      onTapCancel: () {
        if (widget.onPressed != null) {
          _controller.reverse();
        }
      },
      onTap: _handlePress, // Use _handlePress for the main tap logic

      // Apply the scale animation to the child
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SettingSlider extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;
  final String displayValue;
  const SettingSlider({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    required this.displayValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        Row(
          children: [
            Expanded(
              child: Slider(
                thumbColor: Theme.of(context).colorScheme.onPrimaryContainer,
                activeColor: Theme.of(context).colorScheme.secondary,
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: value.round().toString(),
                onChanged: onChanged,
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                displayValue,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

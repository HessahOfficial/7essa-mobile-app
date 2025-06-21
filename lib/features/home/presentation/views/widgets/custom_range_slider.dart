import 'package:flutter/material.dart';

class CustomRangeSlider extends StatelessWidget {
  final String? title;
  final double? min;
  final double? max;
  final RangeValues values;
  final int? divisions;
  final void Function(RangeValues) onChanged;
  final bool isInt;

  const CustomRangeSlider({
    super.key,
    this.title,
    this.min,
    this.max,
    required this.values,
    this.divisions,
    required this.onChanged,
    this.isInt = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "Slider Title:",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        RangeSlider(
          divisions: divisions ?? 10,
          min: min ?? 0,
          max: max ?? 50,
          values: values,
          onChanged: onChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isInt ? values.start.toStringAsFixed(0) : "${values.start}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              isInt ? values.end.toStringAsFixed(0) : "${values.end}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:aqi_today/application/ultils/spacing.dart';
import 'package:flutter/material.dart';

class DataWithTitle extends StatelessWidget {
  const DataWithTitle(
      {super.key,
      required this.data,
      required this.title,
      required this.dataStyle,
      required this.titleStyle,
      required this.padding});
  final String data;
  final String title;
  final TextStyle dataStyle;
  final TextStyle titleStyle;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        SpacingApp.spacingVertical(padding),
        Text(
          data,
          style: dataStyle,
        )
      ],
    );
  }
}

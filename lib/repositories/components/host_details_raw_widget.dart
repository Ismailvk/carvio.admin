import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HostDetailsRowWidget extends StatelessWidget {
  String title;
  String details;
  Color? color;

  HostDetailsRowWidget(
      {Key? key, required this.title, required this.details, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: color),
        ),
        const SizedBox(width: 30),
        Text(
          details,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}

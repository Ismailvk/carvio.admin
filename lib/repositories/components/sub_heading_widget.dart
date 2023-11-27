import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubHeadingWidget extends StatelessWidget {
  String title;
  SubHeadingWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18),
    );
  }
}

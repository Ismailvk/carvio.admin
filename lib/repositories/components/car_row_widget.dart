import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CarRowWidget extends StatelessWidget {
  String image;
  String title;
  CarRowWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 5),
        Text(title)
      ],
    );
  }
}

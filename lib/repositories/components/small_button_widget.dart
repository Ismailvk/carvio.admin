import 'package:admin_side/repositories/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallButtonWidget extends StatelessWidget {
  String title;
  Color color;
  Function()? onPress;
  SmallButtonWidget(
      {super.key, required this.title, this.onPress, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.07,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: color,
        ),
        child: Text(
          title,
          style: TextStyle(color: AppColor.white),
        ),
      ),
    );
  }
}

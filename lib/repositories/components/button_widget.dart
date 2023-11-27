import 'package:admin_side/repositories/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  String title;
  Function()? onPress;
  ButtonWidget({super.key, required this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.1,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColor.black,
        ),
        child: Text(
          title,
          style: TextStyle(color: AppColor.white),
        ),
      ),
    );
  }
}

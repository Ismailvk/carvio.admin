import 'package:admin_side/repositories/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopbarContainer extends StatelessWidget {
  const TopbarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Text(
          'ADMIN',
          textAlign: TextAlign.center,
          style: GoogleFonts.orbitron(
            fontSize: 20,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

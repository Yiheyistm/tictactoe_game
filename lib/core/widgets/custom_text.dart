import 'package:flutter/material.dart';
import 'package:tictactoe_game/core/utils/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Shadow> shadow;
  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.shadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            shadows: shadow,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';

class TextStyles {
  // Name Heading TextStyle
  static TextStyle nameHeadingTextStyle(
      {double size = 18, Color color = CustomColors.black}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      fontFamily: 'Poppins',
      color: color,
    );
  }

  // Main Heading TextStyle
  static TextStyle mainHeadingTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      fontFamily: 'Poppins',
      color: CustomColors.black,
    );
  }

  // Main Heading TextStyle
  static TextStyle belowMainHeadingTextStyle({double fontSize = 15}) {
    return TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      color: CustomColors.black45,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';

class TextStyles {
  // Name Heading TextStyle
  static TextStyle nameHeadingTextStyle({double size = 18}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      fontFamily: 'Poppins',
      color: CustomColors.black,
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
  static TextStyle belowMainHeadingTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 15,
      fontFamily: 'Poppins',
      color: CustomColors.black45,
    );
  }
}

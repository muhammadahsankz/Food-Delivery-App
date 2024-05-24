import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';

class CustomSnackbar {
  static customSnackbar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomColors.green,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

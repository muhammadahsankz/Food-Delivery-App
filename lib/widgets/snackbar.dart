import 'package:flutter/material.dart';

class CustomSnackbar {
  static customSnackbar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

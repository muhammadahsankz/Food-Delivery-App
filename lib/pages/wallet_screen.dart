import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Wallet Screen',
          style: TextStyles.mainHeadingTextStyle(),
        ),
      ),
    );
  }
}

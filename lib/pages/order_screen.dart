import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Orders Screen',
          style: TextStyles.mainHeadingTextStyle(),
        ),
      ),
    );
  }
}

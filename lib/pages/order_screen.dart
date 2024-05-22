import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
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
      body: Column(
        children: [
          Material(
            elevation: 2,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50, bottom: 10),
              child: Text(
                'Orders',
                style: TextStyles.mainHeadingTextStyle(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 30, left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Your Orders,',
                      style: TextStyles.nameHeadingTextStyle(),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            color: CustomColors.orangeFirst.withOpacity(.4),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Image(
                  height: 50,
                  width: 50,
                  image: AssetImage('assets/images/salad2.png'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5',
                      style: TextStyles.mainHeadingTextStyle(),
                    ),
                    Text(
                      'Current orders',
                      style: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Text(
                  'Asian Salad',
                  style: TextStyles.belowMainHeadingTextStyle(),
                ),
                Spacer(),
                Text(
                  '\$10.99',
                  style: TextStyles.belowMainHeadingTextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              color: CustomColors.green.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Text(
                  'Asian Salad',
                  style: TextStyles.nameHeadingTextStyle(size: 16),
                ),
                Spacer(),
                Text(
                  '\$10.99',
                  style: TextStyles.nameHeadingTextStyle(size: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Material(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: Center(
                child: Text(
                  'Admin Home',
                  style: TextStyles.mainHeadingTextStyle(),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.adminAddItemScreen);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Image(
                    width: 40,
                    image: AssetImage('assets/images/salad.png'),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Add Food Items',
                    style: TextStyles.nameHeadingTextStyle(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

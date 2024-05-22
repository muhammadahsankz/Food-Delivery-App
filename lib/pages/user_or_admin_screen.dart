import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class UserOrAdminScreen extends StatelessWidget {
  const UserOrAdminScreen({super.key});

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
                  'Who are you',
                  style: TextStyles.mainHeadingTextStyle(),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.signUpScreen);
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
                    image: AssetImage('assets/images/burger.png'),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'I am a User',
                    style: TextStyles.nameHeadingTextStyle(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.adminLoginScreen);
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
                    'I am an Admin',
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

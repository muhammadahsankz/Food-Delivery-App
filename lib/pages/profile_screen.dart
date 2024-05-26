import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Material(
          elevation: 2,
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 50, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.userOrAdminScreen);
              },
              child: Container(
                height: 45,
                width: 100,
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: CustomColors.green.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyles.nameHeadingTextStyle(size: 13),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: Text(
                'Profile Screen',
                style: TextStyles.mainHeadingTextStyle(),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/admin/admin_add_item_screen.dart';
import 'package:food_delivery_app/pages/admin/admin_home_screen.dart';
import 'package:food_delivery_app/pages/admin/admin_login_screen.dart';
import 'package:food_delivery_app/pages/bottom_nav_bar.dart';
import 'package:food_delivery_app/pages/forgot_password_screen.dart';
import 'package:food_delivery_app/pages/item_datails_screen.dart';
import 'package:food_delivery_app/pages/login_screen.dart';
import 'package:food_delivery_app/pages/onboarding_screen.dart';
import 'package:food_delivery_app/pages/signup_screen.dart';
import 'package:food_delivery_app/pages/user_or_admin_screen.dart';
import 'package:food_delivery_app/routes/route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.itemDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(
                  data: routeSettings.arguments as Map,
                ));
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RouteNames.bottomNavBarScreen:
        return MaterialPageRoute(builder: (context) => BottomNavBar());
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
      case RouteNames.adminLoginScreen:
        return MaterialPageRoute(builder: (context) => AdminLoginScreen());
      case RouteNames.adminHomeScreen:
        return MaterialPageRoute(builder: (context) => AdminHomeScreen());
      case RouteNames.adminAddItemScreen:
        return MaterialPageRoute(builder: (context) => AdminAddItemScreen());
      case RouteNames.userOrAdminScreen:
        return MaterialPageRoute(builder: (context) => UserOrAdminScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text('No Page Found'),
            ),
          );
        });
    }
  }
}

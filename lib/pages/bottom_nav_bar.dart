import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/home_screen.dart';
import 'package:food_delivery_app/pages/order_screen.dart';
import 'package:food_delivery_app/pages/profile_screen.dart';
import 'package:food_delivery_app/pages/wallet_screen.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homeScreen;
  late WalletScreen walletScreen;
  late OrderScreen orderScreen;
  late ProfileScreen profileScreen;
  @override
  void initState() {
    homeScreen = HomeScreen();
    orderScreen = OrderScreen();
    walletScreen = WalletScreen();
    profileScreen = ProfileScreen();
    pages = [homeScreen, orderScreen, walletScreen, profileScreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          currentTabIndex = index;
          setState(() {});
        },
        height: 60,
        animationDuration: Duration(microseconds: 500),
        backgroundColor: CustomColors.white,
        color: CustomColors.green,
        items: [
          Icon(
            Icons.home_outlined,
            color: CustomColors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: CustomColors.white,
          ),
          Icon(
            Icons.wallet_outlined,
            color: CustomColors.white,
          ),
          Icon(
            Icons.person_outlined,
            color: CustomColors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}

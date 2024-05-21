import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/food_category.dart';
import 'package:food_delivery_app/widgets/horizontal_food_list.dart';
import 'package:food_delivery_app/widgets/vertical_food_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool icecreem = false, pizza = false, salad = false, burger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello Ahsan,',
                      style: TextStyles.nameHeadingTextStyle()),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: CustomColors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.shopping_cart,
                      color: CustomColors.white,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text('Delicious Food',
                  style: TextStyles.mainHeadingTextStyle()),
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text('Discover and Get Great Food',
                  style: TextStyles.belowMainHeadingTextStyle()),
            ),
            SizedBox(height: 20),
            Categories(),
            SizedBox(height: 20),
            HorizontalFoodList(),
            SizedBox(height: 20),
            VerticalFoodList(),
          ],
        ),
      ),
    );
  }

  // Categories
  Widget Categories() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FoodCategory(
              onCategoryTap: () {
                burger = true;
                pizza = false;
                icecreem = false;
                salad = false;
                setState(() {});
              },
              imageColor: burger ? CustomColors.white : CustomColors.black,
              imageBackgroundColor:
                  burger ? CustomColors.black : CustomColors.white,
              imagePath: 'assets/images/burger.png'),
          FoodCategory(
              onCategoryTap: () {
                burger = false;
                pizza = true;
                icecreem = false;
                salad = false;
                setState(() {});
              },
              imageColor: pizza ? CustomColors.white : CustomColors.black,
              imageBackgroundColor:
                  pizza ? CustomColors.black : CustomColors.white,
              imagePath: 'assets/images/pizza.png'),
          FoodCategory(
              onCategoryTap: () {
                burger = false;
                pizza = false;
                icecreem = true;
                salad = false;
                setState(() {});
              },
              imageColor: icecreem ? CustomColors.white : CustomColors.black,
              imageBackgroundColor:
                  icecreem ? CustomColors.black : CustomColors.white,
              imagePath: 'assets/images/ice-cream.png'),
          FoodCategory(
              onCategoryTap: () {
                burger = false;
                pizza = false;
                icecreem = false;
                salad = true;
                setState(() {});
              },
              imageColor: salad ? CustomColors.white : CustomColors.black,
              imageBackgroundColor:
                  salad ? CustomColors.black : CustomColors.white,
              imagePath: 'assets/images/salad.png'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/onboarding_items_list.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                itemCount: onboardingContent.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Image.asset(
                            width: double.infinity,
                            height: 300,
                            onboardingContent[index].image),
                        SizedBox(height: 30),
                        Text(
                          textAlign: TextAlign.center,
                          onboardingContent[index].title,
                          style: TextStyles.nameHeadingTextStyle(),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          onboardingContent[index].description,
                          style: TextStyles.belowMainHeadingTextStyle(),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingContent.length,
                (index) => buildDots(index, context),
              ),
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              if (currentIndex == onboardingContent.length - 1) {
                Navigator.pushNamed(context, RouteNames.userOrAdminScreen);
              }
              _pageController.nextPage(
                  duration: Duration(microseconds: 100),
                  curve: Curves.bounceInOut);
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomColors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  currentIndex == onboardingContent.length - 1
                      ? 'Start'
                      : 'Next',
                  style: TextStyles.nameHeadingTextStyle(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      height: 8,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: CustomColors.black45,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

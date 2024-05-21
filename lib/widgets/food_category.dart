import 'package:flutter/material.dart';

class FoodCategory extends StatelessWidget {
  final String imagePath;
  final VoidCallback onCategoryTap;
  final Color imageColor;
  final Color imageBackgroundColor;
  const FoodCategory({
    super.key,
    required this.imagePath,
    required this.onCategoryTap,
    required this.imageColor,
    required this.imageBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCategoryTap,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: imageBackgroundColor,
          ),
          child: Image.asset(
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              color: imageColor,
              imagePath),
        ),
      ),
    );
  }
}

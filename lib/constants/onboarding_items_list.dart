class OnboardingItemsList {
  final String image;
  final String title;
  final String description;

  const OnboardingItemsList({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnboardingItemsList> onboardingContent = [
  OnboardingItemsList(
    image: "assets/images/onboarding1.png",
    title: "Order Your Food Favorites",
    description:
        "Browse through a wide variety of restaurants and cuisines to find exactly what you're craving.",
  ),
  OnboardingItemsList(
    image: "assets/images/onboarding2.png",
    title: "Fast & Easy Delivery",
    description:
        "Get your food delivered right to your doorstep with just a few taps. Track your order in real-time and enjoy hassle-free delivery.",
  ),
  OnboardingItemsList(
    image: "assets/images/onboarding3.jpg",
    title: "Delicious Food, Delivered",
    description:
        "Enjoy hot, fresh meals from your favorite restaurants in the comfort of your own home. We deliver happiness, one bite at a time.",
  ),
];

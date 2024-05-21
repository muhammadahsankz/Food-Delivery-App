class Salad {
  final int id;
  final String type;
  final String name;
  final String description;
  final double price;
  final int deliveryTime;
  final String imageUrl;

  Salad({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.price,
    required this.deliveryTime,
    required this.imageUrl,
  });
}

List<Salad> saladList = [
  Salad(
    id: 0,
    type: 'Mediterranean',
    name: 'Classic Greek Salad',
    description:
        'A refreshing mix of chopped tomatoes, cucumbers, red onions, crumbled feta cheese, Kalamata olives, and oregano dressing.',
    price: 8.99,
    deliveryTime: 45,
    imageUrl:
        'https://th.bing.com/th/id/OIP.NLvFHGQ7g5-9G7pE8yyYMwHaHa?w=516&h=516&rs=1&pid=ImgDetMain',
  ),
  Salad(
    id: 1,

    type: 'Asian',
    name: 'Spicy Thai Peanut Chicken Salad',
    description:
        'Grilled chicken strips tossed with shredded vegetables, crunchy peanuts, and a sweet and spicy Thai peanut dressing.',
    price: 10.49,
    deliveryTime: 50,
    imageUrl:
        'https://example.com/images/spicy-thai-peanut-chicken-salad.jpg', // Replace with actual image URL
  ),
  // Add more salad items here following the same structure
  Salad(
    id: 2,

    type: 'American',
    name: 'Classic Chef\'s Salad',
    description:
        'A hearty combination of chopped ham, turkey, roast beef, Swiss cheese, hard-boiled eggs, tomatoes, cucumbers, and a creamy ranch dressing.',
    price: 11.99,
    deliveryTime: 40,
    imageUrl:
        'https://example.com/images/classic-chefs-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 3,

    type: 'Vegetarian',
    name: 'Quinoa Black Bean Salad',
    description:
        'A protein-packed salad with quinoa, black beans, corn, avocado, red onion, cilantro, and a zesty lime vinaigrette.',
    price: 9.59,
    deliveryTime: 45,
    imageUrl:
        'https://example.com/images/quinoa-black-bean-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 4,

    type: 'Superfood',
    name: 'Kale and Berries Salad',
    description:
        'A nutrient-rich salad with kale, blueberries, strawberries, almonds, sunflower seeds, and a honey balsamic dressing.',
    price: 12.49,
    deliveryTime: 50,
    imageUrl:
        'https://example.com/images/kale-and-berries-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 5,

    type: 'Italian',
    name: 'Caprese Salad',
    description:
        'A classic Italian salad with fresh mozzarella, tomatoes, basil, and a balsamic glaze.',
    price: 9.99,
    deliveryTime: 35,
    imageUrl:
        'https://example.com/images/caprese-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 6,

    type: 'Mexican',
    name: 'Taco Salad',
    description:
        'A flavorful salad with seasoned ground beef, black beans, corn, salsa, avocado, tortilla strips, and a creamy cilantro lime dressing.',
    price: 10.79,
    deliveryTime: 40,
    imageUrl:
        'https://example.com/images/taco-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 7,

    type: 'Cobb',
    name: 'Classic Cobb Salad',
    description:
        'A hearty salad with grilled chicken, bacon, avocado, crumbled blue cheese, tomatoes, red onion, and a creamy vinaigrette dressing.',
    price: 11.49,
    deliveryTime: 45,
    imageUrl:
        'https://example.com/images/classic-cobb-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 8,

    type: 'Fruit',
    name: 'Tropical Fruit Salad',
    description:
        'A refreshing mix of seasonal fruits like mango, pineapple, papaya, kiwi, and grapes with a light honey lime dressing.',
    price: 8.59,
    deliveryTime: 30,
    imageUrl:
        'https://example.com/images/tropical-fruit-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 9,

    type: 'Detox',
    name: 'Clean Greens Salad',
    description:
        'A light and healthy salad with mixed greens, cucumber, cherry tomatoes, red onion, and a light vinaigrette dressing.',
    price: 7.99,
    deliveryTime: 25,
    imageUrl:
        'https://example.com/images/clean-greens-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 10,

    type: 'Asian',
    name: 'Chicken Caesar Salad',
    description:
        "A classic Asian-inspired salad with grilled chicken, romaine lettuce, Parmesan cheese, crispy wonton strips, and a creamy Caesar dressing.",
    price: 10.29,
    deliveryTime: 40,
    imageUrl:
        'https://example.com/images/chicken-caesar-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 11,

    type: 'Mediterranean',
    name: 'Falafel Salad',
    description:
        "A flavorful salad with falafel balls, chopped vegetables, tahini dressing, and pita bread.",
    price: 9.49,
    deliveryTime: 35,
    imageUrl:
        'https://example.com/images/falafel-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 12,

    type: 'Southwestern',
    name: 'Santa Fe Salad',
    description:
        "A zesty salad with grilled chicken, black beans, corn, avocado, red onion, cilantro, and a spicy lime vinaigrette.",
    price: 10.99,
    deliveryTime: 40,
    imageUrl:
        'https://example.com/images/santa-fe-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 13,

    type: 'Protein',
    name: 'Powerhouse Salad',
    description:
        "A protein-packed salad with grilled chicken or tofu, quinoa, black beans, avocado, roasted vegetables, and a balsamic vinaigrette.",
    price: 12.99,
    deliveryTime: 45,
    imageUrl:
        'https://example.com/images/powerhouse-salad.jpg', // Replace with actual image URL
  ),
  Salad(
    id: 14,

    type: 'Grain',
    name: 'Mediterranean Couscous Salad',
    description:
        "A flavorful salad with couscous, chopped vegetables, chickpeas, feta cheese, olives, and a lemon vinaigrette.",
    price: 8.99,
    deliveryTime: 30,
    imageUrl:
        'https://example.com/images/mediterranean-couscous-salad.jpg', // Replace with actual image URL
  ),
];

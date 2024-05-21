import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/salad_items_list.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class HorizontalFoodList extends StatelessWidget {
  const HorizontalFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          itemCount: saladList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.itemDetailsScreen,
                      arguments: {
                        'id': saladList[index].id,
                        'image': 'assets/images/OIP Salad.png',
                        'name': saladList[index].name,
                        'type': saladList[index].type,
                        'description': saladList[index].description,
                        'deliveryTime': saladList[index].deliveryTime,
                        'price': saladList[index].price,
                      });
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'itemImage${saladList[index].id}',
                              child: Image.asset(
                                'assets/images/OIP Salad.png',
                                width: 120,
                                height: 120,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          saladList[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.nameHeadingTextStyle(size: 15),
                        ),
                        Text(
                          saladList[index].type,
                          style: TextStyles.belowMainHeadingTextStyle(),
                        ),
                        Spacer(),
                        Text(
                          "\$" + saladList[index].price.toString(),
                          style: TextStyles.nameHeadingTextStyle(size: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

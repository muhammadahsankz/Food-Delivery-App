import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/salad_items_list.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class VerticalFoodList extends StatelessWidget {
  const VerticalFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          itemCount: saladList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, RouteNames.itemDetailsScreen,
                  //     arguments: {
                  //       'id': saladList[index].id,
                  //       'image': 'assets/images/OIP Salad.png',
                  //       'name': saladList[index].name,
                  //       'type': saladList[index].type,
                  //       'description': saladList[index].description,
                  //       'deliveryTime': saladList[index].deliveryTime,
                  //       'price': saladList[index].price,
                  //     });
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'itemImages${saladList[index].id}',
                              child: Image.asset(
                                'assets/images/salad2.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      saladList[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.nameHeadingTextStyle(
                                          size: 15),
                                    ),
                                  ),
                                  Text(
                                    saladList[index].type,
                                    style:
                                        TextStyles.belowMainHeadingTextStyle(),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$" + saladList[index].price.toString(),
                                    style: TextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
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

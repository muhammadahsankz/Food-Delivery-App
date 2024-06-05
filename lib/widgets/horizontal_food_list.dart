import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/salad_items_list.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class HorizontalFoodList extends StatefulWidget {
  final Stream? specificFoodItemStream;
  const HorizontalFoodList({
    super.key,
    required this.specificFoodItemStream,
  });

  @override
  State<HorizontalFoodList> createState() => _HorizontalFoodListState();
}

class _HorizontalFoodListState extends State<HorizontalFoodList> {
  // Stream? foodItemStream;

  // onLoad() async {
  //   // foodItemStream = await FirestoreDatabaseMethods.getFoodItem('Burger');
  //   foodItemStream = await widget.specificFoodItemStream;
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   onLoad();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: StreamBuilder(
          stream: widget.specificFoodItemStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RouteNames.horizontalListItemDetailsScreen,
                                arguments: {
                                  'id': index,
                                  'image': documentSnapshot['Image'],
                                  'name': documentSnapshot['Name'],
                                  'type': documentSnapshot['Type'],
                                  'description':
                                      documentSnapshot['Description'],
                                  'deliveryTime':
                                      documentSnapshot['DeliveryTime'],
                                  'price': documentSnapshot['Price'],
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
                                        tag: 'itemImage${index}',
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            documentSnapshot['Image'],
                                            width: 120,
                                            height: 120,
                                            loadingBuilder: (context,
                                                imageProvider,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return Image.network(
                                                  documentSnapshot['Image'],
                                                  width: 120,
                                                  height: 120,
                                                );
                                              }
                                              return SizedBox(
                                                width: 120,
                                                height: 120,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: CustomColors.black45,
                                                )),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Text(
                                                  'Error fetching image');
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    documentSnapshot['Name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                  Text(
                                    documentSnapshot['Type'],
                                    style:
                                        TextStyles.belowMainHeadingTextStyle(),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$" + documentSnapshot['Price'].toString(),
                                    style: TextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : ListView(
                    padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
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
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: CustomColors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: CustomColors.grey.shade400,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      '                    ',
                                      style: TextStyles.nameHeadingTextStyle(
                                          size: 15),
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: CustomColors.grey.shade400,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      '',
                                      style: TextStyles
                                          .belowMainHeadingTextStyle(),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: CustomColors.grey.shade400,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      '          ',
                                      style: TextStyles.nameHeadingTextStyle(
                                          size: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  );
          }),
    );
  }
}

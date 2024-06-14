import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class VerticalFoodList extends StatefulWidget {
  final Stream? specificFoodItemStream;

  const VerticalFoodList({
    super.key,
    required this.specificFoodItemStream,
  });

  @override
  State<VerticalFoodList> createState() => _VerticalFoodListState();
}

class _VerticalFoodListState extends State<VerticalFoodList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder(
          stream: widget.specificFoodItemStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RouteNames.verticalListItemDetailsScreen,
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
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: 'itemImages${index}',
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            documentSnapshot['Image'],
                                            width: 100,
                                            height: 100,
                                            loadingBuilder: (context,
                                                imageProvider,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return Image.network(
                                                  documentSnapshot['Image'],
                                                  width: 100,
                                                  height: 100,
                                                );
                                              }
                                              return SizedBox(
                                                width: 100,
                                                height: 100,
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
                                      SizedBox(width: 10),
                                      Container(
                                        height: 100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 30),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                documentSnapshot['Name'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
                                            ),
                                            Text(
                                              documentSnapshot['Type'],
                                              style: TextStyles
                                                  .belowMainHeadingTextStyle(),
                                            ),
                                            Spacer(),
                                            Text(
                                              "\$" +
                                                  documentSnapshot['Price']
                                                      .toString(),
                                              style: TextStyles
                                                  .nameHeadingTextStyle(
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
                    })
                : ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    children: [
                      for (int i = 0; i < 2; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: 300,
                              height: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: CustomColors.grey.shade400,
                                        ),
                                        width: 100,
                                        height: 100,
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        height: 100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 15),
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    CustomColors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                '                                 ',
                                                style: TextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    CustomColors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                '                    ',
                                                style: TextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    CustomColors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                '               ',
                                                style: TextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
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
                        )
                    ],
                  );
          }),
    );
  }
}

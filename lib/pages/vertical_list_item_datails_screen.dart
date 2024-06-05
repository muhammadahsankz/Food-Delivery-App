import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/firestore_database.dart';
import 'package:food_delivery_app/services/shared_prefs.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';

class VerticalListItemDetailsScreen extends StatefulWidget {
  final dynamic data;
  const VerticalListItemDetailsScreen({super.key, required this.data});

  @override
  State<VerticalListItemDetailsScreen> createState() =>
      _VerticalListItemDetailsScreenState();
}

class _VerticalListItemDetailsScreenState
    extends State<VerticalListItemDetailsScreen> {
  double totalPrice = 0;
  int quantity = 1;
  String? id;
  getSharedPrefs() async {
    id = await SharedPrefsHelper.getUserId();
    setState(() {});
  }

  onLoad() async {
    await getSharedPrefs();
    setState(() {});
  }

  @override
  void initState() {
    onLoad();
    totalPrice = widget.data['price'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 200,
                  child: Hero(
                      tag: 'itemImages${widget.data['id']}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          widget.data['image'],
                          width: MediaQuery.of(context).size.width / 1.5,
                          loadingBuilder:
                              (context, imageProvider, loadingProgress) {
                            if (loadingProgress == null) {
                              return Image.network(
                                widget.data['image'],
                                width: MediaQuery.of(context).size.width / 1.5,
                              );
                            }
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: CustomColors.black45,
                              )),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Error fetching image');
                          },
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              widget.data['name'],
              style: TextStyles.nameHeadingTextStyle(),
            ),
            Row(
              children: [
                Text(
                  widget.data['type'],
                  style: TextStyles.nameHeadingTextStyle(size: 15),
                ),
                Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (quantity > 1) {
                          quantity--;
                          totalPrice = totalPrice -
                              double.parse(widget.data['price'].toString());
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: CustomColors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.remove_outlined,
                          size: 20,
                        )),
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 20,
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          style: TextStyles.nameHeadingTextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        quantity++;
                        totalPrice = widget.data['price'] + totalPrice;
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: CustomColors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.add_outlined,
                          size: 20,
                        )),
                        padding: EdgeInsets.all(10),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              widget.data['description'],
              style: TextStyles.belowMainHeadingTextStyle(),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'Delivery time:',
                  style: TextStyles.nameHeadingTextStyle(size: 15),
                ),
                SizedBox(width: 20),
                Icon(Icons.alarm_outlined),
                SizedBox(width: 5),
                Text(
                  widget.data['deliveryTime'].toString() + ' minutes',
                  style: TextStyles.nameHeadingTextStyle(size: 15),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total price',
                      style: TextStyles.nameHeadingTextStyle(size: 15),
                    ),
                    Text(
                      '\$$totalPrice',
                      style: TextStyles.nameHeadingTextStyle(size: 15),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    if (await FirebaseAuth.instance.currentUser != null) {
                      Map<String, dynamic> addFoodToCart = {
                        'Name': widget.data['name'],
                        'Quantity': quantity,
                        'TotalAmount': totalPrice,
                        'Image': widget.data['image'],
                      };
                      await FirestoreDatabaseMethods.addFoodToCart(
                          addFoodToCart, id!);
                      CustomSnackbar.customSnackbar(
                          context, 'Item successfully added to cart');
                    } else {
                      CustomSnackbar.customSnackbar(context, 'Login First',
                          backgroundColor: CustomColors.red);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.black45),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          'Add to cart',
                          style: TextStyles.nameHeadingTextStyle(size: 15),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.shopping_cart_outlined)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

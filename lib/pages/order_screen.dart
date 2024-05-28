import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/firestore_database.dart';
import 'package:food_delivery_app/services/shared_prefs.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? id;
  double total = 0, wallet = 0, totalAmount2 = 0;
  bool isLoading = false;
  Stream? foodStream;
  getSharedPrefs() async {
    id = await SharedPrefsHelper.getUserId();
    wallet = (await SharedPrefsHelper.getUserWallet())!;
    setState(() {});
  }

  onLoad() async {
    getSharedPrefs();
    foodStream = await FirestoreDatabaseMethods.getFoodCart('a@g.com');
    setState(() {});
  }

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      totalAmount2 = total;
      setState(() {});
    });
    onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: foodStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? Column(
                    children: [
                      Material(
                        elevation: 2,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 50, bottom: 10),
                          child: Text(
                            'Food Cart',
                            style: TextStyles.mainHeadingTextStyle(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, right: 30, left: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Your Orders,',
                                  style: TextStyles.nameHeadingTextStyle(),
                                ),
                                Spacer(),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage('assets/images/logo.png'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        color: CustomColors.orangeFirst.withOpacity(.4),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Image(
                              height: 50,
                              width: 50,
                              image: AssetImage('assets/images/salad.png'),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data.docs.length}',
                                  style: TextStyles.mainHeadingTextStyle(),
                                ),
                                Text(
                                  'Current orders',
                                  style: TextStyles.belowMainHeadingTextStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data.docs[index];
                              total = total + documentSnapshot['TotalAmount'];
                              return Badge(
                                label: Text(
                                  documentSnapshot['Quantity'].toString(),
                                  style: TextStyles.nameHeadingTextStyle(
                                      color: CustomColors.white, size: 12),
                                ),
                                backgroundColor: Colors.red,
                                alignment: Alignment.topRight,
                                offset: Offset(-100, -10),
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  padding: EdgeInsets.only(
                                      right: 30, top: 15, bottom: 15, left: 20),
                                  decoration: BoxDecoration(
                                    color: CustomColors.green.shade300,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        documentSnapshot['Image'],
                                        width: 55,
                                        height: 55,
                                      ),
                                      SizedBox(width: 15),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          documentSnapshot['Name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          // 'Asian Salad',
                                          style:
                                              TextStyles.nameHeadingTextStyle(
                                                  size: 16),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        '\$${documentSnapshot['TotalAmount']}',
                                        style: TextStyles.nameHeadingTextStyle(
                                            size: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              'Total Price:',
                              style: TextStyles.nameHeadingTextStyle(),
                            ),
                            Spacer(),
                            Text(
                              '\$$total',
                              style: TextStyles.nameHeadingTextStyle(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          isLoading = true;
                          double amount = wallet - totalAmount2;
                          await FirestoreDatabaseMethods.updateUserWallet(
                              id!, amount);
                          await SharedPrefsHelper.setUserWallet(amount);
                          isLoading = false;
                          CustomSnackbar.customSnackbar(
                              context, 'Your order is placed successfully');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: CustomColors.green.shade300,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: CustomColors.green,
                                  ),
                                )
                              : Text(
                                  'Checkout',
                                  style:
                                      TextStyles.nameHeadingTextStyle(size: 15),
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                : Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: CustomColors.green,
                      ),
                    ),
                  );
          }),
    );
  }
}

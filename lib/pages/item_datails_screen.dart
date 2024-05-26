import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

class ItemDetailsScreen extends StatefulWidget {
  final dynamic data;
  const ItemDetailsScreen({super.key, required this.data});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int totalPrice = 0;
  int quantity = 1;

  @override
  void initState() {
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
                Hero(
                    tag: 'itemImage${widget.data['id']}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        widget.data['image'],
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                    )),
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
                              int.parse(widget.data['price'].toString());
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
                Container(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

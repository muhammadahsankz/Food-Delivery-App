import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/firestore_database.dart';
import 'package:food_delivery_app/services/shared_prefs.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<int> alreadyDefinedAmounts = [100, 500, 1000, 2000];
  int alreadyDefinedAmount = 0;
  String? wallet;
  String? userId;
  bool isLoading = false;

  @override
  void initState() {
    getSharePrefsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 2,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50, bottom: 10),
              child: Text(
                'Wallet',
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
                      'Hello Ahsan,',
                      style: TextStyles.nameHeadingTextStyle(),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            color: CustomColors.green.shade300,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Image(
                  height: 50,
                  width: 50,
                  image: AssetImage('assets/images/salad2.png'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wallet == null
                        ? CircularProgressIndicator(
                            color: CustomColors.black45,
                          )
                        : Text(
                            '\$$wallet',
                            style: TextStyles.mainHeadingTextStyle(),
                          ),
                    Text(
                      'Your balance',
                      style: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < alreadyDefinedAmounts.length; i++)
                GestureDetector(
                  onTap: () {
                    alreadyDefinedAmount = alreadyDefinedAmounts[i];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          changePickedContainerColor(alreadyDefinedAmounts[i]),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '\$${alreadyDefinedAmounts[i]}',
                      style: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              if (alreadyDefinedAmount != 0) {
                wallet = '${int.parse(wallet!) + alreadyDefinedAmount}';
                updateWallet();
                alreadyDefinedAmount = 0;
                CustomSnackbar.customSnackbar(
                    context, 'Amount added successfully');
              } else {
                CustomSnackbar.customSnackbar(
                    context, 'Select an amount to add');
              }
            },
            child: Container(
              height: 45,
              width: 180,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                color: CustomColors.green.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: CustomColors.black45,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Add Money',
                        style: TextStyles.nameHeadingTextStyle(size: 16),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  // Get locally stored data
  getSharePrefsData() async {
    wallet = await SharedPrefsHelper.getUserWallet();
    userId = await SharedPrefsHelper.getUserId();
    setState(() {});
  }

  // Update Wallet in Locally and on Firestore
  updateWallet() async {
    isLoading = true;
    setState(() {});
    await SharedPrefsHelper.setUserWallet(wallet!);
    await FirestoreDatabaseMethods.updateUserWallet(userId!, wallet!);
    isLoading = false;
    setState(() {});
  }

  // Change picked container color
  Color changePickedContainerColor(int amount) {
    return alreadyDefinedAmount == amount
        ? CustomColors.green.shade200
        : CustomColors.transparent;
  }
}

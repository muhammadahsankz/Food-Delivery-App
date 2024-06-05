import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/services/auth.dart';
import 'package:food_delivery_app/services/firestore_database.dart';
import 'package:food_delivery_app/services/shared_prefs.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _imagePicker = ImagePicker();
  File? selectedImage;
  String? id;
  String? profilePic =
      'https://firebasestorage.googleapis.com/v0/b/food-delivery-app-fd20e.appspot.com/o/itemImages%2FLAb1p3Ury2?alt=media&token=ea1325fe-9fc7-481a-8f2a-770a31c22d73';
  String? name, email;

  // Get Shared Preferences
  getSharedPrefs() async {
    id = await SharedPrefsHelper.getUserId();
    profilePic = await SharedPrefsHelper.getUserProfilePic();
    name = await SharedPrefsHelper.getUserName();
    email = await SharedPrefsHelper.getUserEmail();
    setState(() {});
  }

  // Pick Image Function
  Future getImage() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    uploadItem();
    setState(() {});
  }

  // Upload Item on Firebase
  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instanceFor(
              bucket: 'gs://food-delivery-app-fd20e.appspot.com')
          .ref()
          .child('itemImages')
          .child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPrefsHelper.setUserProfilePic(downloadUrl);
      profilePic = await SharedPrefsHelper.getUserProfilePic();
      await FirestoreDatabaseMethods.uploadProfilePic(id!, downloadUrl);
      setState(() {});
    }
  }

  @override
  void initState() {
    getSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
              color: CustomColors.green,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(60, 60),
              )),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if (await FirebaseAuth.instance.currentUser != null) {
                    getImage();
                  } else {
                    CustomSnackbar.customSnackbar(
                        context, 'Login to set profile picture',
                        backgroundColor: CustomColors.red);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(35),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: profilePic == ''
                            ? Image.asset('assets/images/profilepic.png')
                            : Image.network(
                                profilePic!,
                                loadingBuilder:
                                    (context, imageProvider, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return Image.network(
                                      profilePic!,
                                    );
                                  }
                                  return Center(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: CustomColors.black45,
                                      )),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Text('Error fetching image');
                                },
                              ),
                      )),
                ),
              ),
              SizedBox(height: 30),
              profileContainer(
                'Name',
                name == null || name == ''
                    ? (name == null ? 'Loading...' : 'Login First')
                    : name!,
              ),
              SizedBox(height: 20),
              profileContainer(
                  'Email',
                  email == null || email == ''
                      ? (email == null ? 'Loading...' : 'Login First')
                      : email!),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              height: 300,
                              child: Column(
                                children: [
                                  Text(
                                    'Terms & Conditions',
                                    style: TextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    'These Terms and Conditions govern your access to and use of the Food Delivery App, developed and operated by Muhammad Ahsan. By accessing or using the App, you agree to be bound by these Terms & Conditions.',
                                                style: TextStyle(
                                                    color: CustomColors.black)),
                                            TextSpan(
                                              text: '\n\n1. Services',
                                              style: TextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 14),
                                            ),
                                            TextSpan(
                                                text:
                                                    '\nThe App provides a platform that connects users with restaurants offering food delivery services. We facilitate online ordering, payment processing, and order tracking. We are not a food service provider and do not guarantee the quality, safety, or timeliness of any food or services offered by the restaurants.',
                                                style: TextStyle(
                                                    color: CustomColors.black)),
                                            TextSpan(
                                              text: '\n\n2. User Accounts',
                                              style: TextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 14),
                                            ),
                                            TextSpan(
                                                text:
                                                    '''\nYou may need to create an account ("Account") to use certain features of the App. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. 
You agree to:
Provide accurate and complete information when creating your Account.
Keep your account information up-to-date.
Notify us immediately of any unauthorized use of your Account or any other security breach.''',
                                                style: TextStyle(
                                                    color: CustomColors.black)),
                                            TextSpan(
                                              text: '\n\n3. Orders',
                                              style: TextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 14),
                                            ),
                                            TextSpan(
                                                text:
                                                    '''\nYou are responsible for reviewing the restaurant's menu, pricing, and delivery fees before placing an order.
You can cancel an order before it is confirmed by the restaurant, but cancellation fees may apply.
We are not responsible for any errors or delays in orders placed through the App.''',
                                                style: TextStyle(
                                                    color: CustomColors.black)),
                                            TextSpan(
                                              text: '\n\n4. Payment',
                                              style: TextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 14),
                                            ),
                                            TextSpan(
                                                text:
                                                    '''\nYou agree to pay for all orders placed through the App using a valid payment method.
We may use secure third-party payment processors to handle transactions.
We are not responsible for any errors or issues related to payment processing.''',
                                                style: TextStyle(
                                                    color: CustomColors.black)),
                                            TextSpan(
                                              text: '\n\n5. Changes to Terms',
                                              style: TextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 14),
                                            ),
                                            TextSpan(
                                                text:
                                                    '\nWe may revise these Terms at any time by updating this page. You are bound by any revisions and should therefore periodically visit this page to review the current Terms.',
                                                style: TextStyle(
                                                    color: CustomColors.black)),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: secondProfileContainer('Terms & Conditions')),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              height: 250,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Delete Account?',
                                    style: TextStyles.nameHeadingTextStyle(),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    'Are you sure you want to delete the account?',
                                    style: TextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Once account is permanently deleted it cannot be recovered.',
                                    style: TextStyles.belowMainHeadingTextStyle(
                                        fontSize: 13),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      await SharedPrefsHelper.setFoodCategory(
                                          'Burger');
                                      await SharedPrefsHelper.setUserEmail('');
                                      await SharedPrefsHelper.setUserId('');
                                      await SharedPrefsHelper.setUserName('');
                                      await SharedPrefsHelper.setUserProfilePic(
                                          '');
                                      await SharedPrefsHelper.setUserWallet(0);
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        AuthMethods.deleteAccount();
                                      }
                                      Navigator.pushNamed(
                                          context, RouteNames.signUpScreen);
                                      CustomSnackbar.customSnackbar(context,
                                          'Your Account is permanently deleted');
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: CustomColors.red.shade300,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Delete',
                                          style:
                                              TextStyles.nameHeadingTextStyle(
                                                  size: 15),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: secondProfileContainer('Delete Account')),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () async {
                    await SharedPrefsHelper.setFoodCategory('Burger');
                    await SharedPrefsHelper.setUserEmail('');
                    await SharedPrefsHelper.setUserId('');
                    await SharedPrefsHelper.setUserName('');
                    await SharedPrefsHelper.setUserProfilePic('');
                    await SharedPrefsHelper.setUserWallet(0);
                    AuthMethods.logoutUser();
                    Navigator.pushNamed(context, RouteNames.signUpScreen);
                    CustomSnackbar.customSnackbar(
                        context, 'Logout Successfully',
                        backgroundColor: CustomColors.red.shade300);
                  },
                  child: secondProfileContainer('Logout')),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
          child: Text(
            name == null || name == ''
                ? (name == null ? 'Loading...' : 'Welcome')
                : name!,
            style: TextStyles.mainHeadingTextStyle(),
          ),
        )
      ],
    ));
  }

  Widget profileContainer(String title, String description) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.nameHeadingTextStyle(size: 17),
              ),
              Text(
                description,
                style: TextStyles.belowMainHeadingTextStyle(fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget secondProfileContainer(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.nameHeadingTextStyle(size: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/services/auth.dart';
import 'package:food_delivery_app/services/shared_prefs.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
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
  String? profileImage, name, email;

  // Get Shared Preferences
  getSharedPrefs() async {
    profileImage = await SharedPrefsHelper.getUserProfile();
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
      await SharedPrefsHelper.setUserProfile(downloadUrl);
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
                onTap: () {
                  getImage();
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
                    child: selectedImage == null
                        ? Icon(Icons.person)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: profileImage == null
                                ? Image.file(
                                    selectedImage!,
                                  )
                                : Image.network(profileImage!)),
                  ),
                ),
              ),
              SizedBox(height: 30),
              profileContainer('Name', name == null ? 'Loading...' : name!),
              SizedBox(height: 20),
              profileContainer('Email', email == null ? 'Loading...' : email!),
              SizedBox(height: 20),
              secondProfileContainer('Terms & Conditions'),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    AuthMethods.deleteAccount();
                    Navigator.pushNamed(context, RouteNames.signUpScreen);
                  },
                  child: secondProfileContainer('Delete Account')),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    AuthMethods.logoutUser();
                    Navigator.pushNamed(context, RouteNames.signUpScreen);
                  },
                  child: secondProfileContainer('Logout')),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
          child: Text(
            name == null ? 'Loading...' : name!,
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/services/firestore_database.dart';
import 'package:food_delivery_app/services/shared_prefs.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight / 2.5,
            width: screenWidth,
            padding: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.green,
                  CustomColors.green.shade300,
                ],
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                      width: screenWidth / 1.5,
                      height: 120,
                      'assets/images/signup.png'),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: screenHeight / 4),
              // height: screenHeight / 1.3,
              width: screenWidth,
              decoration: BoxDecoration(
                color: CustomColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                width: screenWidth,
                decoration: BoxDecoration(
                  // color: CustomColors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "SignUp",
                        style: TextStyles.mainHeadingTextStyle(),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyles.nameHeadingTextStyle(size: 15),
                          prefixIcon: Icon(
                            Icons.person_outlined,
                            color: CustomColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyles.nameHeadingTextStyle(size: 15),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: CustomColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyles.nameHeadingTextStyle(size: 15),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: CustomColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: CustomColors.green,
                          ),
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator())
                                : Text(
                                    "SignUp",
                                    style: TextStyles.nameHeadingTextStyle(
                                        size: 16),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyles.belowMainHeadingTextStyle(),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, RouteNames.loginScreen),
                            child: Text(
                              "Login",
                              style: TextStyles.nameHeadingTextStyle(size: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNames.bottomNavBarScreen);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              'Login as Guest',
                              style: TextStyles.nameHeadingTextStyle(size: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Registration Fuction
  signUp() async {
    isLoading = true;
    setState(() {});
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // To store data on Firebase Firestore
      // String id = randomAlphaNumeric(10);
      Map<String, dynamic> addUserInfo = {
        'Name': nameController.text,
        'Email': emailController.text,
        'Wallet': 0.0,
        'Id': emailController.text,
        'ProfilePic': '',
      };
      await FirestoreDatabaseMethods.addUserDetails(
          addUserInfo, emailController.text);

      // To store data locally
      await SharedPrefsHelper.setUserId(emailController.text);
      await SharedPrefsHelper.setUserName(nameController.text);
      await SharedPrefsHelper.setUserEmail(emailController.text);
      await SharedPrefsHelper.setUserWallet(0.0);
      await SharedPrefsHelper.setUserProfilePic('');

      // Other
      isLoading = false;
      setState(() {});
      Navigator.pushReplacementNamed(context, RouteNames.bottomNavBarScreen);
      CustomSnackbar.customSnackbar(context, 'Registered Successfully');
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        isLoading = false;
        setState(() {});
        CustomSnackbar.customSnackbar(context, 'Select a strong password',
            backgroundColor: CustomColors.red);
      } else if (e.code == 'email-already-in-use') {
        isLoading = false;
        setState(() {});
        CustomSnackbar.customSnackbar(context, 'This email already exists',
            backgroundColor: CustomColors.red);
      } else {
        isLoading = false;
        setState(() {});
        CustomSnackbar.customSnackbar(context, e.code,
            backgroundColor: CustomColors.red);
      }
    }
  }
}

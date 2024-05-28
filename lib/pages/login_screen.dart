import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/services/firestore_database.dart';
import 'package:food_delivery_app/services/shared_prefs.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            height: screenHeight / 2,
            width: screenWidth,
            padding: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.orangeFirst,
                  CustomColors.orangeSecond,
                ],
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                      width: screenWidth / 1.5,
                      height: 150,
                      'assets/images/login.png'),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: screenHeight / 4),
              height: screenHeight / 1.5,
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
                        "Login",
                        style: TextStyles.mainHeadingTextStyle(),
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
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteNames.forgotPasswordScreen),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyles.nameHeadingTextStyle(size: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: CustomColors.orangeFirst,
                          ),
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator())
                                : Text(
                                    "Login",
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
                            "Don't have an account?",
                            style: TextStyles.belowMainHeadingTextStyle(),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, RouteNames.signUpScreen),
                            child: Text(
                              "SignUp",
                              style: TextStyles.nameHeadingTextStyle(size: 15),
                            ),
                          ),
                        ],
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

  //Login Function
  login() async {
    isLoading = true;
    setState(() {});
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // To store data locally
      final data = await FirestoreDatabaseMethods.getUserDataFromFirebase(
          emailController.text);
      if (data != null) {
        SharedPrefsHelper.setUserId(data['Id']);
        SharedPrefsHelper.setUserName(data['Name']);
        SharedPrefsHelper.setUserEmail(data['Email']);
        SharedPrefsHelper.setUserWallet(data['Wallet']);
      } else {}

      isLoading = false;
      setState(() {});
      Navigator.pushNamed(context, RouteNames.bottomNavBarScreen);
      CustomSnackbar.customSnackbar(context, 'Login Successful');
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        isLoading = false;
        setState(() {});
        CustomSnackbar.customSnackbar(context, 'User not found',
            backgroundColor: CustomColors.red);
      } else if (e.code == 'invalid-email') {
        isLoading = false;
        setState(() {});
        CustomSnackbar.customSnackbar(context, 'Invalid Email',
            backgroundColor: CustomColors.red);
      } else if (e.code == 'wrong-password') {
        isLoading = false;
        setState(() {});
        CustomSnackbar.customSnackbar(context, 'Invalid Password',
            backgroundColor: CustomColors.red);
      } else if (e.code == 'invalid-credential') {
        isLoading = false;
        setState(() {});
        CustomSnackbar.customSnackbar(context, 'Invalid Username/Password',
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

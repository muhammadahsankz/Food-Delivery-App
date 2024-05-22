import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/snackbar.dart';

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
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight / 4),
            height: screenHeight / 2,
            width: screenWidth,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
              padding:
                  EdgeInsets.only(top: 20, bottom: 30, right: 20, left: 20),
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
                          return 'Enter email';
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
                          return 'Enter password';
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
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {}
                        login();
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                                  style:
                                      TextStyles.nameHeadingTextStyle(size: 16),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80, bottom: 150),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                      width: screenWidth / 1.5,
                      height: 80,
                      'assets/images/logo.png'),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyles.belowMainHeadingTextStyle(),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, RouteNames.signUpScreen),
                      child: Text(
                        "SignUp",
                        style: TextStyles.nameHeadingTextStyle(size: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //Login Function
  login() async {
    try {
      isLoading = true;
      setState(() {});
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      isLoading = false;
      setState(() {});
      Navigator.pushNamed(context, RouteNames.bottomNavBarScreen);
      CustomSnackbar.customSnackbar(context, 'Login Successful');
    } on FirebaseException catch (e) {
      isLoading = true;
      setState(() {});
      if (e.code == 'user-not-found') {
        CustomSnackbar.customSnackbar(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        CustomSnackbar.customSnackbar(context, 'Wrong Password');
      } else if (e.code == 'invalid-credential') {
        CustomSnackbar.customSnackbar(context, 'Invalid Username/Password');
      }
      isLoading = false;
      setState(() {});
    }
  }
}

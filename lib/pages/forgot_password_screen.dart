import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/snackbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Recover Your Password',
                    style: TextStyles.nameHeadingTextStyle(size: 20),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Enter your email',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter email to reset the password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'e.g. abc@gmail.com',
                      hintStyle: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                      resetPassword();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: CustomColors.orangeFirst),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Send Email',
                                style:
                                    TextStyles.nameHeadingTextStyle(size: 15),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
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
                          "Create",
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
    );
  }

  //Reset Password Function
  resetPassword() async {
    try {
      isLoading = true;
      setState(() {});
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      isLoading = false;
      setState(() {});
      CustomSnackbar.customSnackbar(
          context, 'Check email to reset the password');
    } on FirebaseAuthException catch (e) {
      print(e.code);
      isLoading = true;
      setState(() {});
      if (e.code == 'user-not-found') {
        CustomSnackbar.customSnackbar(context, 'Incorrect email');
      }
      isLoading = false;
      setState(() {});
    }
  }
}

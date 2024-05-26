import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.grey.shade300,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image(
                  width: 250,
                  image: AssetImage('assets/images/adminPanel.png'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Admin Panel',
                style: TextStyles.mainHeadingTextStyle(),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: CustomColors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Username',
                          hintStyle: TextStyles.belowMainHeadingTextStyle(),
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyles.belowMainHeadingTextStyle(),
                        ),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            loginAdmin();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: CustomColors.green,
                          ),
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color: CustomColors.black45,
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Admin Login Function
  loginAdmin() async {
    isLoading = true;
    setState(() {});
    FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != usernameController.text.trim() &&
            result.data()['password'] != passwordController.text.trim()) {
          isLoading = false;
          setState(() {});
          CustomSnackbar.customSnackbar(
              context, 'Incorrect Username & Password',
              backgroundColor: CustomColors.red);
        } else if (result.data()['username'] !=
            usernameController.text.trim()) {
          isLoading = false;
          setState(() {});
          CustomSnackbar.customSnackbar(context, 'Incorrect Username',
              backgroundColor: CustomColors.red);
        } else if (result.data()['password'] !=
            passwordController.text.trim()) {
          isLoading = false;
          setState(() {});
          CustomSnackbar.customSnackbar(context, 'Incorrect Password',
              backgroundColor: CustomColors.red);
        } else {
          isLoading = false;
          setState(() {});
          Navigator.pushNamed(context, RouteNames.adminHomeScreen);
          CustomSnackbar.customSnackbar(context, 'Login Successful');
        }
      });
    });
  }
}

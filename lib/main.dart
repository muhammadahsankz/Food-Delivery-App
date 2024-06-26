import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/routes/routes.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyArA0ERn10942SftahrINheLh_F7Z5Kk04",
    appId: "1:624453794316:android:021e7fa3fed54ac3accc29",
    messagingSenderId: "624453794316",
    projectId: "food-delivery-app-fd20e",
    // storageBucket: "gs://food-delivery-app-fd20e.appspot.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.onboardingScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

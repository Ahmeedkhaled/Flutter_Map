import 'package:flutter/material.dart';
import 'package:my_profile/core/routes.dart';
import 'package:my_profile/core/theme_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_profile/presentation/screens/home_page.dart';
import 'package:my_profile/presentation/screens/login_screen.dart';
import 'package:my_profile/presentation/screens/otp_screen.dart';
void main()async {
    WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Profile",
      initialRoute: MyRoutes.loginScreen,
      routes: {
        MyRoutes.homePage: (context) => HomePage(),
        MyRoutes.loginScreen: (context) => LoginScreen(),
        MyRoutes.otpScreen: (context) => OtpScreen(),
      },
      theme: ThemeApp.themeLight,
    );
  }
}

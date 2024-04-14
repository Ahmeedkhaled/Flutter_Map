import 'package:flutter/material.dart';
import 'package:my_profile/core/routes.dart';
import 'package:my_profile/core/theme_app.dart';
import 'package:my_profile/view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Profile",
      initialRoute: MyRoutes.homePage,
      routes: {
        MyRoutes.homePage: (context) => HomePage(),
      },
      theme: ThemeApp.themeLight,
    );
  }
}

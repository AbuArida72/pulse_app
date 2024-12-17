import 'package:flutter/material.dart';
import 'package:pulse/screens/splash.dart';
import 'package:pulse/helpers/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: CustomColor.primary,
        fontFamily: 'Ubuntu',
      ),
      home: SplashScreen(),
    );
  }
}

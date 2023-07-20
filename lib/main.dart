import 'package:flutter/material.dart';
import 'package:morfunapp/radioState.dart';
import 'package:morfunapp/screens/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'morfun app',
      theme: ThemeData(
        canvasColor: const Color(0xffE1AEFF),
        fontFamily: 'Poppins',
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCustomSplashScreen();
  }
}

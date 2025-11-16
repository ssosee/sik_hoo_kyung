import 'package:flutter/material.dart';
import 'package:sik_hoo_kyung/screen/login_screen.dart';
import 'package:sik_hoo_kyung/screen/main_screen.dart';
import 'package:sik_hoo_kyung/screen/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainScreen(),
      // home: SplashScreen(),
      // routes: {
      //   '/login': (context) => LoginScreen(),
      //   '/main': (context) => MainScreen(),
      // },
    ),
  );
}

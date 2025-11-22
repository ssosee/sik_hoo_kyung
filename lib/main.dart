import 'package:flutter/material.dart';
import 'package:sik_hoo_kyung/screen/main_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // debug 배너 제거
      home: MainScreen(),
      // home: SplashScreen(),
      // routes: {
      //   '/login': (context) => LoginScreen(),
      //   '/main': (context) => MainScreen(),
      // },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:sik_hoo_kyung/screen/home_screen.dart';
import 'package:sik_hoo_kyung/screen/setting_screen.dart';

import 'history_screen.dart';
import 'main_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  Widget? currentScreen;
  int selectedBottomNavigationIndex = 0;

  void selectBottomNavigationBar(int index) {
    setState(() {
      selectedBottomNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('appBar')),
      body: IndexedStack(
        index: selectedBottomNavigationIndex,
        children: [
          Center(child: HomeScreen()),
          Center(child: HistoryScreen()),
          Center(child: SettingScreen()),
        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(
        selectedBottomNavigationIndex: selectedBottomNavigationIndex,
        onDestinationSelected: selectBottomNavigationBar,
      ),
    );
  }
}

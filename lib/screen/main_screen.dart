import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sik_hoo_kyung/screen/home_screen.dart';
import 'package:sik_hoo_kyung/screen/setting_screen.dart';

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
      HapticFeedback.selectionClick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('⛰️ 금강산도 식후경 🤭')),
      body: IndexedStack(
        index: selectedBottomNavigationIndex,
        children: [
          Center(child: HomeScreen()),
          // Center(child: HistoryScreen()),
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

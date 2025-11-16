import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final int selectedBottomNavigationIndex;
  final Function(int) onDestinationSelected;

  const MainBottomNavigationBar({
    super.key,
    required this.selectedBottomNavigationIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedBottomNavigationIndex,
      indicatorColor: Colors.greenAccent,
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.home, size: 35),
          icon: Icon(Icons.home_outlined, size: 30),
          label: "홈",
        ),
        // NavigationDestination(
        //   selectedIcon: Icon(Icons.directions_walk),
        //   icon: Icon(Icons.directions_walk_outlined),
        //   label: "기록",
        // ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings, size: 35),
          icon: Icon(Icons.settings_outlined, size: 30),
          label: "설정",
        ),
      ],
    );
  }
}

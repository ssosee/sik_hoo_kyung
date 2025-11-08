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
      indicatorColor: Colors.cyan,
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: "홈",
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.directions_walk),
          icon: Icon(Icons.directions_walk_outlined),
          label: "기록",
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_outlined),
          label: "설정",
        ),
      ],
    );
  }
}

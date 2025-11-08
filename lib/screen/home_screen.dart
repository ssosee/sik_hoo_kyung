import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('appBar'),),
      body: Center(child: Text('body'),),
      bottomNavigationBar: BottomAppBar(child: Text('bottomNavigationBar'),)
    );
  }
}

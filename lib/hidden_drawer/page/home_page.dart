import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/drawer_menu_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: DrawerMenuIcon(
          onPressed: openDrawer,
        ),
        title: const Text('Home Page'),
      ),
    );
  }
}

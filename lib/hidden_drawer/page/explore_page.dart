import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/drawer_menu_icon.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: DrawerMenuIcon(
          onPressed: openDrawer,
        ),
        title: const Text('Explore Page'),
      ),
    );
  }
}

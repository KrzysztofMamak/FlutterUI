import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/drawer_menu_icon.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: DrawerMenuIcon(
          onPressed: openDrawer,
        ),
        title: const Text('Favorites Page'),
      ),
    );
  }
}

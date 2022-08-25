import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/drawer_menu_icon.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  final VoidCallback openDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: DrawerMenuIcon(
          onPressed: openDrawer,
        ),
        title: const Text('Messages Page'),
      ),
    );
  }
}
